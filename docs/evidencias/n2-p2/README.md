# Evidências de execução — N2-P2

O [relatório](../../gcs/RELATORIO-N2-P2.md) registra o estado observado e as
pendências. Esta pasta não contém uma recusa de push enquanto o teste real não
for executado após a proteção da `main`.

| Evidência | Como obter | Estado inicial |
|---|---|---|
| [`verificacao-inicial.json`](verificacao-inicial.json) | Consulta real da API, contendo visibilidade, branch, merge, colaboradores e environments. | Coletada em 16/11/2026; registra pendências, não a conclusão. |
| `recusa-push-main.txt` | Executar `bash scripts/gcs/registrar-recusa-main.sh --executar`. | Pendente; arquivo ainda não gerado. |
| Print da proteção da main | Settings → Branches → regra `main`, mostrando PR, 1 aprovação, histórico linear e sem bypass. | Pendente. |
| Print do par com Write | Settings → Collaborators, depois do aceite de @Vzleopoldo. | Pendente. |
| Print de staging | Environment e restrição a branches protegidas. | Pendente. |
| Print de production | Environment, required reviewer @maccedofilho e branches protegidas. | Pendente. |

Guardar somente evidências reais, sem tokens, dados de clientes ou links privados
de convite. Publicar por PR revisado. Prints e texto copiado da recusa são
aceitos pelo roteiro do professor.
