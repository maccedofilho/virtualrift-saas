# Concluir a N2-P2 no GitHub

Os arquivos do plano e da organização estão preparados. Os itens abaixo exigem
a sessão administrativa de @maccedofilho; a integração utilizada nesta preparação
recebeu HTTP 403 nessas operações.

## 1. Aplicar as configurações

Com Git e [GitHub CLI](https://cli.github.com/) instalados, em sua própria máquina:

```bash
gh auth login
gh auth setup-git
git clone https://github.com/maccedofilho/virtualrift-saas.git
cd virtualrift-saas
bash scripts/gcs/configurar-github.sh --aplicar
```

Se já tiver o clone, atualize-o em vez de clonar novamente. Use sua conta
`maccedofilho` com permissão de administração do repositório. Não compartilhe
tokens no código ou no chat. O script configura merge, ambientes, main e convite
do par; não implanta a aplicação. Se a main já estiver protegida, ele para para
preservar as regras existentes: confira-as manualmente pela lista abaixo.

Também é possível fazer tudo pelo site do GitHub:

| Local nas Settings | Configuração exigida |
|---|---|
| General → Pull Requests | Habilitar apenas Allow squash merging. Desmarcar merge commits e rebase merging. |
| General → Squash / Default commit message | Pull request title and description. |
| General → Pull Requests | Marcar Automatically delete head branches. |
| Environments → staging | Deployment branches and tags: Protected branches only. |
| Environments → New environment → production | Required reviewers: `maccedofilho`; salvar. Prevent self-review desmarcado. Deployment branches and tags: Protected branches only. |
| Branches → Add classic branch protection rule | Branch name pattern: `main`. |
| Regra da main | Require a pull request before merging; Require approvals: **1**; Dismiss stale pull request approvals when new commits are pushed. |
| Regra da main | Require linear history; Do not allow bypassing the above settings. Manter force pushes e deletions desabilitados. |
| Regra da main | Nesta Aula 1, deixar a exigência de status checks para a Aula 2. Se já houver checks obrigatórios, preservá-los. |
| Collaborators → Add people | Convidar `Vzleopoldo` com acesso **Write**. |

Não marcar aprovação obrigatória do CODEOWNER proprietário como substituto do
par, pois o autor não pode aprovar o próprio PR.

## 2. Confirmar o par

@Vzleopoldo precisa aceitar o convite na própria conta GitHub. Depois do aceite,
confirmar em Settings → Collaborators que ele aparece com acesso de escrita.
Um convite pendente não satisfaz o critério. Capturar a tela sem mostrar dados
privados ou links de convite.

## 3. Registrar a recusa real do push

Execute somente depois de configurar a proteção da main, autenticado como
proprietário. O script confirma a proteção, cria um commit vazio sobre a main
remota e tenta enviá-lo por HTTPS, sem force push e sem trocar sua branch local.

```bash
bash scripts/gcs/registrar-recusa-main.sh --executar
```

Uma recusa de branch protegida será salva em
`docs/evidencias/n2-p2/recusa-push-main.txt`, com data, SHAs, comando e saída real.
Erro de autenticação, erro 403 da integração ou falha de rede não contam como
recusa da proteção. O script só grava a evidência quando identifica a recusa da
regra. Se o push for aceito, o teste falhou: corrija a regra antes de prosseguir.

## 4. Publicar as evidências

1. Criar uma branch para as evidências.
2. Adicionar o log real e os prints da proteção, dos ambientes e do acesso do par.
3. Atualizar os estados de `RELATORIO-N2-P2.md` com os resultados verificados.
4. Abrir PR, obter aprovação de @Vzleopoldo e integrar por squash.

## 5. Texto para a entrega

Usar após conferir os itens anteriores e substituir o campo da evidência:

```text
Projeto: VirtualRift
Repositório: https://github.com/maccedofilho/virtualrift-saas
Plano de GCS: https://github.com/maccedofilho/virtualrift-saas/blob/main/docs/gcs/PLANO-GCS.md
Par de revisão: @Vzleopoldo (acesso de escrita aceito e conferido).
Evidência da recusa do push direto na main: [anexar o log real ou print da recusa].
Ambientes: staging e production, com @maccedofilho como revisor obrigatório de production.
```

Não enviar a frase de acesso aceito ou de ambientes concluídos enquanto esses
estados ainda estiverem pendentes.
