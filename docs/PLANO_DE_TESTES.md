# Plano de testes do SmartRoutine

## Objetivo

Verificar as funções centrais do MVP e registrar critérios mínimos para uma demonstração confiável.

## Testes automatizados

| ID | Cenário | Resultado esperado |
|---|---|---|
| TA01 | Abrir o aplicativo sem dados | Exibir o nome do aplicativo, estado vazio e botão de adição |
| TA02 | Adicionar uma tarefa válida | Exibir a tarefa na lista e persistir o conteúdo |
| TA03 | Concluir uma tarefa | Marcar a caixa e riscar o título |

Os cenários TA01 a TA03 estão implementados em `test/widget_test.dart` com armazenamento simulado.

## Testes manuais recomendados

| ID | Cenário | Procedimento | Resultado esperado |
|---|---|---|---|
| TM01 | Título vazio | Abrir o diálogo e confirmar sem texto | Nenhuma tarefa criada |
| TM02 | Persistência | Criar tarefas, fechar e reabrir o app | Tarefas recuperadas |
| TM03 | Exclusão | Excluir uma tarefa existente | Item removido e estatísticas atualizadas |
| TM04 | Estatísticas | Concluir parte das tarefas | Percentual compatível com concluídas sobre total |
| TM05 | Regras | Variar o percentual entre as faixas | Recomendação correspondente à faixa |
| TM06 | Conteúdo local inválido | Simular JSON corrompido | Aplicativo inicia com lista vazia sem encerrar |
| TM07 | Usabilidade | Executar o fluxo em tela pequena | Elementos legíveis e acionáveis sem sobreposição |

## Critério de aceite

O MVP pode ser demonstrado quando a análise estática não apresenta erros, os testes automatizados passam e os cenários manuais centrais não apresentam falhas bloqueadoras.

## Testes futuros

- testes unitários isolados para cálculo e recomendação;
- testes de integração com persistência real;
- testes de acessibilidade com leitor de tela e contraste;
- testes em diferentes versões e tamanhos de tela Android;
- pesquisa de usabilidade com participantes e métricas de conclusão de tarefa;
- testes de segurança, privacidade e sincronização quando houver backend.
