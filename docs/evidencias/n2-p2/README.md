# Evidências de execução — N2-P2

- [Verificação inicial](verificacao-inicial.json): estado anterior à configuração, preservado como histórico.
- [Verificação final](verificacao-final.json): visibilidade pública, main protegida, permissão Write de @Vzleopoldo, política de merge e configurações observadas nos environments.
- [Recusa pelo site: Commit changes](recusa-commit-site.md): texto original e screenshot do bloqueio ao proprietário.
- [Recusa complementar via API](recusa-push-main.txt): erro original do GitHub ao tentar atualizar a main sem PR.
- [Relatório](../../gcs/RELATORIO-N2-P2.md): resultados e limites.

A recusa foi coletada via API GraphQL `updateRefs`, não por CLI `git push`.
O commit de teste possui a mesma árvore da main, sem alteração da aplicação.
Após a recusa, a main manteve seu SHA. Nenhum log de terminal ou screenshot
foi simulado. As configurações de branches e environments foram verificadas
na interface autenticada do GitHub; o JSON identifica essa origem.

O [PR #133](https://github.com/maccedofilho/virtualrift-saas/pull/133) foi aprovado
e integrado por @Vzleopoldo em 16/11/2026. As evidências originais já estão na
main. Complementos seguem o mesmo fluxo de revisão por PR.
