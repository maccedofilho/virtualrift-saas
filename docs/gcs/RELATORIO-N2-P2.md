# Execução do plano de GCS — N2-P2

**Projeto:** VirtualRift · **Responsável:** @maccedofilho · **Data:** 16/11/2026

## Resultado verificado

| Critério | Resultado |
|---|---|
| Organização e plano publicado | Estrutura backend, frontend, libs e infra preservada; [plano de GCS](PLANO-GCS.md) publicado na main. |
| Repositório acessível | Repositório público, confirmado pela API. |
| Proteção da main | PR obrigatório, 1 aprovação, descarte de aprovações obsoletas, histórico linear e nenhum bypass, inclusive administrador. |
| Recusa de atualização direta na main | Teste real recusado: `Changes must be made through a pull request`. [Texto completo](../evidencias/n2-p2/recusa-push-main.txt). |
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

A atualização do relatório e das evidências é proposta por branch e pull
request, respeitando a proteção. **Aprovação humana e merge deste PR ainda são
necessários para que estes registros atualizados apareçam na main.** Não se
alega revisão realizada. @Vzleopoldo pode revisar o diff e aprovar com sua
própria conta; depois o responsável realiza squash merge sem bypass.
