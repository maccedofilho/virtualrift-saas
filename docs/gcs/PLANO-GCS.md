# Plano de Gestão de Configuração de Software — VirtualRift

| Identificação | Definição |
|---|---|
| Item de configuração | IC-DOC-001 |
| Versão documental | 1.0 |
| Data | 16/11/2026 |
| Responsável | @maccedofilho |
| Par de revisão indicado | @Vzleopoldo — acesso efetivo depende do aceite do convite |
| Repositório oficial | <https://github.com/maccedofilho/virtualrift-saas> |
| Referência didática | [Aula 1 — ONGConecta](https://github.com/lzcamargo/ongconecta/blob/main/docs/aulas/aula-1-repositorio.md) |

Este plano é um item de configuração versionado junto ao produto. Suas regras
definem o processo a implantar; o estado efetivamente verificado e as pendências
constam no [relatório de execução](RELATORIO-N2-P2.md). Publicar o plano não
substitui configurar as regras no GitHub.

## 1. Objetivo e escopo

Controlar a identificação, alteração, revisão, rastreabilidade e liberação dos
artefatos do VirtualRift, plataforma SaaS de análise de segurança com múltiplos
tenants. O escopo inclui backend Java 21/Spring Boot/Maven, frontend
React/TypeScript/Vite/pnpm, bibliotecas, infraestrutura, pipelines, testes e
documentação. A execução desta etapa corresponde à preparação do repositório da
Aula 1 e aos cinco critérios da avaliação N2-P2.

## 2. Papéis e responsabilidades

| Papel | Responsável | Responsabilidades |
|---|---|---|
| Desenvolvedor líder e gestor de configuração | @maccedofilho | Manter este plano, administrar o repositório, implementar mudanças e preservar as evidências. |
| Par de revisão | @Vzleopoldo | Aceitar acesso Write, revisar PRs de outro autor, verificar os critérios de aceite e aprovar ou solicitar correções. |
| Responsável pela produção | @maccedofilho | Autorizar os deployments vinculados ao environment `production`. |
| Avaliador | Professor da disciplina | Consultar o repositório público, o plano e as evidências de execução. |

O autor não aprova o próprio PR. A aprovação de deployment pelo líder é uma
etapa distinta da revisão de código pelo par. Mudanças de alto risco exigem
avaliação conjunta do líder e do revisor; uma aprovação do próprio autor não
substitui essa análise.

## 3. Organização, ambientes e branches

### 3.1. Organização do repositório

| Caminho | Conteúdo controlado |
|---|---|
| `backend/` | Serviços, scanners, contratos, testes, configurações e migrações SQL. |
| `frontend/` | Dashboard, pacotes compartilhados, testes, manifests e lockfile pnpm. |
| `libs/` | Área de bibliotecas Java compartilhadas e respectivos POMs. |
| `infra/` | Helm, Terraform, scripts de entrega, observabilidade e documentação operacional. |
| `.github/` | Workflows, CODEOWNERS, templates de PR/Issue e Dependabot. |
| `docs/gcs/` | Plano de GCS, relatório e roteiro da avaliação. |
| `docs/evidencias/n2-p2/` | Evidências verificáveis da execução. |
| `scripts/gcs/` | Apoio à configuração administrativa e ao registro do teste da main. |
| `.claude/` e `.agents/` | Orientações e recursos de desenvolvimento já existentes. |

### 3.2. Ambientes

| Ambiente | Uso | Controle obrigatório |
|---|---|---|
| Local | Desenvolvimento e testes antes de abrir PR. | Configuração local ignorada pelo Git; modelos `.env.example`. |
| `staging` | Homologação da versão integrada. | GitHub Environment com `Protected branches only`. |
| `production` | Liberação aos usuários. | GitHub Environment com `Protected branches only` e @maccedofilho como required reviewer. |

Em `production`, `Prevent self-review` deve ficar desmarcado, conforme a Aula 1,
para permitir ao líder aprovar um deployment que iniciou. Isso não autoriza
aprovar seu próprio PR. O environment deve existir com a aprovação configurada
antes de qualquer execução de produção. URLs e credenciais de deploy são
configurações operacionais; criar um environment não comprova que houve deploy.

### 3.3. Branching, commits e integração

- `main` representa a linha integrada e deve estar protegida, inclusive para administradores.
- Mudanças devem usar branches curtas, como `feature/<issue>-<descricao>`,
  `fix/<issue>-<descricao>` ou `docs/<descricao>`.
- Commits e títulos de PR seguem Conventional Commits: `feat`, `fix`, `docs`,
  `test`, `refactor`, `chore` ou `security`, com escopo quando aplicável.
- A integração ocorre por PR com pelo menos **uma aprovação de outra pessoa**.
- Novos commits invalidam aprovações anteriores (`Dismiss stale approvals`).
- A `main` exige histórico linear e bloqueia push direto, force push e exclusão.
- `Do not allow bypassing the above settings` deve estar habilitado.
- Somente squash merge deve estar habilitado; título e descrição do PR formam
  a mensagem do commit. A branch de origem deve ser excluída automaticamente.
- Nesta etapa não serão inventados checks obrigatórios. A seleção de checks
  na proteção pertence à Aula 2; os workflows existentes são preservados.

## 4. Identificação e controle das configurações

### 4.1. Itens de configuração e identificação

| ID | Item | Identificação da versão / localização |
|---|---|---|
| IC-DOC-001 | Plano de GCS | Este arquivo, versão documental e SHA Git. |
| IC-DOC-002 | Instruções e evidências | `README.md`, `docs/gcs/` e `docs/evidencias/`. |
| IC-SRC-001 | Código e testes backend | `backend/`, identificado pelo SHA Git. |
| IC-SRC-002 | Código e testes frontend | `frontend/`, identificado pelo SHA Git. |
| IC-LIB-001 | Bibliotecas compartilhadas | `libs/` e pacotes compartilhados do produto. |
| IC-DEP-001 | Dependências Java | POM pai, BOMs e POMs dos módulos com versões declaradas/herdadas. |
| IC-DEP-002 | Dependências frontend | `frontend/package.json`, manifests dos workspaces e `frontend/pnpm-lock.yaml`. |
| IC-INF-001 | Infraestrutura e entrega | `infra/`, Dockerfiles, Compose e lockfiles Terraform. |
| IC-CI-001 | Automação | `.github/workflows/` e `.github/dependabot.yml`. |
| IC-GOV-001 | Colaboração e padrões | CODEOWNERS, templates, `.gitignore` e `.gitattributes`. |
| IC-ENV-001 | Modelos de configuração | `.env.example` e modelo do dashboard, sem credenciais reais. |
| IC-GH-001 | Configurações no GitHub | Proteção da main, merge, permissões e environments; comprovadas por consulta/print. |

O frontend usa **pnpm**, portanto o lockfile aplicável é `pnpm-lock.yaml`;
não se deve criar um `package-lock.json` concorrente. A instalação reproduzível
usa `corepack pnpm install --frozen-lockfile`. Dependências Java são resolvidas
pelos POMs e BOMs versionados.

Dependências instaladas, `target/`, `dist/`, logs, `.env` e estados Terraform
nunca integram a baseline. `.gitattributes` fixa LF para arquivos de texto.
Secrets reais devem permanecer em mecanismos próprios, como GitHub Secrets ou
Vault, conforme a infraestrutura existente. Credenciais eventualmente expostas
devem ser revogadas no serviço de origem; apagar o arquivo não remove o histórico.

### 4.2. Solicitação e rastreabilidade da mudança

1. Registrar a necessidade e os critérios de aceite em uma Issue, usando os
   templates de funcionalidade ou defeito quando aplicáveis.
2. Criar branch a partir da `main` atualizada.
3. Alterar os itens necessários e atualizar sua documentação.
4. Abrir PR com contexto, decisão e validação executada; vincular a Issue por
   `Closes #<numero>` quando houver.
5. Obter revisão independente, corrigir observações e integrar por squash.

O histórico de Issues, PRs e commits fornece a cadeia necessidade → decisão →
validação → revisão → versão integrada. Mudanças deste plano passam pelo mesmo
processo depois da proteção inicial do repositório.

## 5. Verificação, aprovação e auditoria

### 5.1. Verificações técnicas

| Escopo | Comando existente |
|---|---|
| Backend | `cd backend && mvn -B -ntp test` |
| Frontend | `cd frontend && corepack pnpm test` |
| Tipagem frontend | `cd frontend && corepack pnpm lint` |
| Build frontend | `cd frontend && corepack pnpm build` |
| Higiene da mudança | `git diff --check` |

Os workflows existentes também validam entrega e segurança. O registro de uma
validação deve indicar o comando, resultado e commit; testes não executados não
devem ser descritos como aprovados. Mudanças somente documentais são verificadas
por leitura, links e estrutura, sem alegar execução da suíte da aplicação.

### 5.2. Revisão e controle de acesso

O revisor verifica o propósito, impactos, critérios de aceite, ausência de
segredos e evidências de teste apropriadas. @Vzleopoldo precisa ter acesso Write
efetivo: convite pendente e menção em CODEOWNERS não satisfazem esse requisito.
Não se deve habilitar aprovação obrigatória do CODEOWNER autor como substituto
da revisão por pares, pois o autor não aprova o próprio PR.

### 5.3. Auditoria desta entrega

Conferir plano publicado na branch padrão, acesso público, arquivos básicos,
templates, acesso do par, squash, ambientes e proteção. Executar um push direto
controlado somente depois de confirmar que a proteção inclui administradores.
Guardar a saída real de recusa; erro de autenticação ou permissão da integração
não comprova proteção da `main`. O procedimento está no
[roteiro de conclusão](CONCLUIR-N2-P2.md).

## 6. Baselines, liberação e recuperação

Uma baseline é identificada pelo SHA integrado na `main`, seus manifests,
lockfiles e documentação. A baseline inicial da avaliação só será considerada
completa após a resolução das pendências do relatório de execução.

O projeto já contém workflows de CI, imagens, deploy e rollback. A liberação
operacional deve usar artefatos identificados pelo SHA, homologação em staging
e aprovação de produção pelo líder, seguindo `infra/DEPLOYMENT.md`. Esta entrega
não exige disparar deploy ou publicar uma nova versão da aplicação.

Correções devem ser registradas por novo PR; alterações integradas são revertidas
por `git revert` em branch de correção e revisão independente. Não reescrever o
histórico da `main`. Evidências públicas não podem conter tokens, senhas, dados
de clientes ou URLs de convite privadas.

## 7. Registro de alterações do plano

| Versão | Data | Alteração |
|---|---|---|
| 1.0 | 16/11/2026 | Plano inicial adaptado ao VirtualRift e aos critérios da Aula 1 / N2-P2. |
