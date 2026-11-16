# Execução do plano de GCS — N2-P2

**Projeto:** VirtualRift · **Responsável:** @maccedofilho · **Data:** 16/11/2026

## Resultado verificado

| Critério | Resultado |
|---|---|
| Organização e plano publicado | Estrutura backend, frontend, libs e infra preservada; [plano de GCS](PLANO-GCS.md) publicado na main. |
| Repositório acessível | Repositório público, confirmado pela API. |
| Proteção da main | PR obrigatório, 1 aprovação, descarte de aprovações obsoletas, histórico linear e nenhum bypass, inclusive administrador. |
| Recusa de atualização direta na main | Teste pelo site: `You can’t commit to main because it is a protected branch`. [Texto e print](../evidencias/n2-p2/recusa-commit-site.md). |
| Par com acesso de escrita | @Vzleopoldo com permissão efetiva `write`, confirmada pela API. Não é apenas convite pendente. |
| staging | Criado; aceita somente branches protegidas. |
| production | Criado; @maccedofilho como revisor obrigatório; self-review permitido; somente branches protegidas. |
| Política de merge | Somente squash; título e descrição do PR; exclusão automática da branch após merge. |

As configurações administrativas foram concluídas pela sessão autenticada do
proprietário no GitHub. [Registro final](../evidencias/n2-p2/verificacao-final.json)
distingue consultas da API das configurações observadas na interface.
O [registro inicial](../evidencias/n2-p2/verificacao-inicial.json) permanece como
histórico anterior à configuração e não descreve mais o estado atual.

## Teste real de recusa

### Pelo site (Commit changes)

Com a conta do proprietário, foi editado um comentário Markdown inofensivo
no README de evidências da main. Ao clicar **Commit changes...**, o GitHub
bloqueou commit direto e apresentou somente a opção de criar branch e PR:
**“You can’t commit to main because it is a protected branch”**.
[Registro e screenshot real](../evidencias/n2-p2/recusa-commit-site.md).
O teste foi cancelado e a edição descartada, sem criar commit ou branch.

### Teste complementar via API

Foi criado um commit vazio (mesma árvore da main, sem mudança de arquivos),
e tentada a atualização direta de `refs/heads/main` via API GitHub GraphQL
`updateRefs`, sem force. O servidor recusou por proteção de branch e exigiu PR.
A main permaneceu em `0bf88aed35bd4354c1c72a499092d6e20dde689e`.

O registro é uma recusa real de atualização direta via API, **não uma saída
de `git push` no terminal**. Não foi fabricado log de CLI. O professor pode
conferir a proteção nas configurações e o texto original no arquivo de evidência.
O script `scripts/gcs/registrar-recusa-main.sh` continua disponível caso se
deseje complementar a evidência com uma execução local de `git push`.

## Itens de configuração versionados

- Plano de GCS, relatório e roteiro em `docs/gcs/`.
- `.gitattributes` com LF e `.gitignore`.
- `.env.example` sem valores reais.
- `.github/CODEOWNERS`, template de PR e templates de Issues.
- POMs Maven, `frontend/pnpm-lock.yaml` e modelo de ambiente do dashboard.
- Scripts de configuração e coleta de evidência em `scripts/gcs/`.
- README com índice de GCS e orientações de execução.

## Validação e limites

Esta atualização é exclusivamente documental: nenhum código, dependência,
workflow, secret ou deployment foi alterado. Não foram executados testes da
aplicação. As evidências contêm respostas reais do GitHub sem credenciais.

O [PR #133](https://github.com/maccedofilho/virtualrift-saas/pull/133) foi aprovado
por @Vzleopoldo às 23:12:39 UTC e integrado pelo mesmo colaborador às 23:13:04 UTC
em 16/11/2026, no commit `4c441ae539be8ab90142e8f86e9bf46d0dc25425`.
Esse registro comprova revisão por outra pessoa com acesso de escrita.
Atualizações documentais posteriores seguem o mesmo fluxo de PR e aprovação,
sem desativar a proteção.
