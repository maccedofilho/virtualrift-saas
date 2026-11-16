# Execução do plano de GCS — N2-P2

**Projeto:** VirtualRift · **Responsável:** @maccedofilho · **Data:** 16/11/2026

Este relatório distingue os artefatos preparados das configurações efetivamente
verificadas. A entrega ainda depende das pendências administrativas abaixo.

| Critério | Resultado verificado |
|---|---|
| Organização e plano publicado | Estrutura de backend, frontend, libs e infra preservada; [plano de GCS](PLANO-GCS.md) e modelos de colaboração adicionados nesta entrega. |
| Repositório acessível | Público em `maccedofilho/virtualrift-saas`, confirmado pela API. |
| Recusa do push direto na main | **Pendente.** A API retornou `protected: false`; não foi tentado push na main desprotegida. |
| Par com acesso de escrita | **Pendente.** @Vzleopoldo indicado pelo responsável; a lista de colaboradores consultada contém apenas o proprietário. Convite e aceite ainda precisam ocorrer. |
| Environments staging e production | **Pendente.** Existe somente `staging`, sem política de branches; `production` ainda precisa ser criado com o proprietário como required reviewer. |
| Somente squash merge | **Pendente.** Merge commit e rebase estão habilitados, e a exclusão automática de branches está desabilitada. |

## Artefatos versionados nesta preparação

- `docs/gcs/PLANO-GCS.md`: objetivo, papéis, ambientes, branching, inventário,
  mudanças, revisão, baselines, auditoria e recuperação.
- `.gitattributes`: arquivos de texto com final de linha LF.
- `.env.example`: modelo de nomes de variáveis do backend, sem valores reais.
- `.github/CODEOWNERS`: proprietário e caminhos reais do projeto.
- `.github/pull_request_template.md` e templates de Issues de funcionalidade e defeito.
- `scripts/gcs/configurar-github.sh`: configuração inicial com sessão administrativa.
- `scripts/gcs/registrar-recusa-main.sh`: coleta da saída real do push recusado,
  com verificação prévia da proteção e sem alterar os arquivos da aplicação.
- README com índice de GCS e comandos de execução mais portáveis.

O projeto já possui `.gitignore`, `frontend/pnpm-lock.yaml`, POMs Maven e modelo
de ambiente do dashboard. Esses artefatos foram preservados.

## Validação desta preparação

- `git diff --cached --check`: sem erros de whitespace.
- `bash -n scripts/gcs/*.sh`: sintaxe válida nos dois scripts.
- YAML dos dois templates de Issue: leitura válida e identificadores únicos.
- Links relativos dos novos documentos e modelo `.env.example`: conferidos.
- Guardas dos scripts verificadas em ambiente isolado: credencial administrativa
  insuficiente, main já protegida e tentativa de teste antes da proteção param
  sem chamadas de mutação.

Os testes da aplicação não foram executados nesta alteração documental. A
[consulta inicial da API](../evidencias/n2-p2/verificacao-inicial.json) registra
os estados reais de configuração e o SHA da main consultada.

## Limitação encontrada

As chamadas de administração da integração retornaram HTTP 403,
`Resource not accessible by integration`, ao tentar ajustar os tipos de merge,
criar `production` e conceder acesso ao par. A leitura da proteção da branch
também exige uma permissão que essa credencial não possui. A permissão `admin`
do usuário na resposta do repositório não amplia o escopo da credencial usada.

Esse erro **não é evidência de recusa de push em branch protegida**. Nenhum print
ou log dessa recusa foi fabricado. As configurações devem ser concluídas na
sessão administrativa do proprietário, conforme o [roteiro](CONCLUIR-N2-P2.md).

## Critério para encerrar a execução

Atualizar este relatório após configurar o GitHub, confirmar o aceite de
@Vzleopoldo e registrar o teste real. Guardar as evidências descritas em
[`docs/evidencias/n2-p2/`](../evidencias/n2-p2/README.md). A validação documental
não equivale à execução dos testes da aplicação ou a um deployment.
