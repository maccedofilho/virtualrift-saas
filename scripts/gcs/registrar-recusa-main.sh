#!/usr/bin/env bash
# Registra a saída REAL do teste solicitado na Aula 1.
# Não troca a branch atual nem altera arquivos do produto. Nunca usa force push.
set -euo pipefail

if [[ "${1:-}" != "--executar" ]]; then
  echo "Uso: bash scripts/gcs/registrar-recusa-main.sh --executar"
  echo "Requer gh com acesso administrativo e Git autenticado como maccedofilho."
  exit 0
fi

REPO="maccedofilho/virtualrift-saas"
ROOT=$(git rev-parse --show-toplevel)
[[ "$(gh repo view --json nameWithOwner --jq .nameWithOwner)" == "$REPO" ]] || {
  echo "Execute dentro do clone de $REPO." >&2; exit 1;
}
[[ "$(gh api user --jq .login)" == "maccedofilho" ]] || {
  echo "Use a conta proprietária para testar que administradores também estão bloqueados." >&2; exit 1;
}
# Este teste não deve ser executado enquanto a main estiver desprotegida.
PROTECAO=$(gh api "repos/$REPO/branches/main/protection" \
  --jq '.enforce_admins.enabled == true and .required_linear_history.enabled == true and .required_pull_request_reviews.required_approving_review_count >= 1')
[[ "$PROTECAO" == "true" ]] || {
  echo "Configure a proteção completa da main antes de testar." >&2; exit 1;
}

git fetch "https://github.com/$REPO.git" main
BASE=$(git rev-parse FETCH_HEAD)
# Commit vazio: mesmos arquivos da main, sem modificar o checkout local.
# skip ci evita execução de pipelines caso a proteção esteja incorreta.
COMMIT_TESTE=$(git commit-tree "$BASE^{tree}" -p "$BASE" \
  -m "docs(gcs): testa bloqueio de push direto [skip ci]")
EVIDENCIAS="$ROOT/docs/evidencias/n2-p2"
mkdir -p "$EVIDENCIAS"
SAIDA=$(mktemp)
trap 'rm -f "$SAIDA"' EXIT

set +e
git push "https://github.com/$REPO.git" "$COMMIT_TESTE:refs/heads/main" >"$SAIDA" 2>&1
CODIGO=$?
set -e

if [[ "$CODIGO" -eq 0 ]]; then
  cat "$SAIDA"
  echo "TESTE FALHOU: o push foi aceito. A proteção precisa ser corrigida." >&2
  echo "O commit contém os mesmos arquivos da main; não foi registrada recusa." >&2
  exit 1
fi
if ! grep -Eqi 'GH006|GH013|protected branch|changes must be made through a pull request' "$SAIDA"; then
  cat "$SAIDA"
  echo "Falha não reconhecida como proteção de branch; não serve como evidência." >&2
  exit 1
fi

{
  echo "Teste real de push direto na main — VirtualRift / N2-P2"
  echo "Data UTC: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Repositório: https://github.com/$REPO"
  echo "Conta gh: maccedofilho (Git deve usar a mesma conta)"
  echo "Base da main: $BASE"
  echo "Commit vazio tentado: $COMMIT_TESTE"
  echo "Comando: git push https://github.com/$REPO.git $COMMIT_TESTE:refs/heads/main"
  echo "Código de saída: $CODIGO"
  echo
  cat "$SAIDA"
} >"$EVIDENCIAS/recusa-push-main.txt"

cat "$EVIDENCIAS/recusa-push-main.txt"
echo "Evidência salva. Publique o arquivo por branch + PR aprovado pelo par."
