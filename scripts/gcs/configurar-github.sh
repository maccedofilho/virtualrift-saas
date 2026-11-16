#!/usr/bin/env bash
# Configuração inicial específica da Aula 1 / N2-P2 no VirtualRift.
# Requer GitHub CLI autenticado como maccedofilho, com Administration: write.
# Não cria credenciais, não altera visibilidade e não dispara deployments.
set -euo pipefail

REPO="maccedofilho/virtualrift-saas"
LIDER="maccedofilho"
REVISOR="Vzleopoldo"

if [[ "${1:-}" != "--aplicar" ]]; then
  cat <<'USAGE'
Uso: bash scripts/gcs/configurar-github.sh --aplicar

Aplica somente em maccedofilho/virtualrift-saas:
  - squash merge, título/descrição do PR e exclusão automática da branch;
  - staging/production restritos a branches protegidas;
  - production com maccedofilho como required reviewer;
  - main: PR, 1 aprovação, invalidar aprovação antiga, histórico linear,
    incluir administradores, bloquear force push e exclusão;
  - convite Write para Vzleopoldo, se ainda não tiver esse acesso.

Execute com sua própria sessão do gh, com permissão administrativa.
O script para antes de modificar se a main já estiver protegida, para não
sobrescrever regras mais fortes. Nesse caso use o roteiro de conferência.
O aceite do convite por Vzleopoldo continua necessário.
USAGE
  [[ "${1:-}" == "--help" || -z "${1:-}" ]]
  exit
fi

command -v gh >/dev/null || { echo "Instale o GitHub CLI (gh)." >&2; exit 1; }
[[ "$(gh api user --jq .login)" == "$LIDER" ]] || {
  echo "Autentique o gh como $LIDER antes de executar." >&2; exit 1;
}
[[ "$(gh api "repos/$REPO" --jq .visibility)" == "public" ]] || {
  echo "O repositório precisa estar público. Confira a visibilidade manualmente." >&2; exit 1;
}
[[ "$(gh api "repos/$REPO/branches/main" --jq .protected)" == "false" ]] || {
  echo "A main já está protegida: confira as regras pelo roteiro, sem sobrescrevê-las." >&2; exit 1;
}
# A leitura de convites exige administração efetiva; detecta tokens limitados
# antes de aplicar qualquer configuração. Não imprime convites privados.
gh api "repos/$REPO/invitations" >/dev/null
LIDER_ID=$(gh api "users/$LIDER" --jq .id)
gh api "users/$REVISOR" >/dev/null

echo "Aplicando configuração inicial em $REPO"
gh api --method PATCH "repos/$REPO" \
  -F allow_squash_merge=true -F allow_merge_commit=false -F allow_rebase_merge=false \
  -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY \
  -F delete_branch_on_merge=true >/dev/null

gh api --method PUT "repos/$REPO/environments/staging" --input - >/dev/null <<'JSON'
{"deployment_branch_policy":{"protected_branches":true,"custom_branch_policies":false}}
JSON

gh api --method PUT "repos/$REPO/environments/production" --input - >/dev/null <<JSON
{
  "prevent_self_review":false,
  "reviewers":[{"type":"User","id":$LIDER_ID}],
  "deployment_branch_policy":{"protected_branches":true,"custom_branch_policies":false}
}
JSON

gh api --method PUT "repos/$REPO/branches/main/protection" --input - >/dev/null <<'JSON'
{
  "required_status_checks":null,
  "enforce_admins":true,
  "required_pull_request_reviews":{
    "required_approving_review_count":1,
    "dismiss_stale_reviews":true,
    "require_code_owner_reviews":false
  },
  "restrictions":null,
  "required_linear_history":true,
  "allow_force_pushes":false,
  "allow_deletions":false
}
JSON

PAR_PODE_ESCREVER=$(gh api --paginate "repos/$REPO/collaborators" \
  --jq '.[] | select(.login == "Vzleopoldo") | .permissions.push')
if [[ "$PAR_PODE_ESCREVER" != "true" ]]; then
  gh api --method PUT "repos/$REPO/collaborators/$REVISOR" -f permission=push >/dev/null
  echo "Convite Write enviado/atualizado para $REVISOR. Ele precisa aceitar."
else
  echo "$REVISOR já tem acesso de escrita."
fi

echo "Resumo das configurações efetivas:"
gh api "repos/$REPO" \
  --jq '{visibility,allow_merge_commit,allow_rebase_merge,allow_squash_merge,delete_branch_on_merge,squash_merge_commit_title,squash_merge_commit_message}'
gh api "repos/$REPO/branches/main/protection" \
  --jq '{enforce_admins:.enforce_admins.enabled,required_linear_history:.required_linear_history.enabled,reviews:.required_pull_request_reviews}'
gh api "repos/$REPO/environments" \
  --jq '.environments[] | {name,protection_rules,deployment_branch_policy}'
echo "Confira o aceite do par e execute o teste de recusa descrito no roteiro."
