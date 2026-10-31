# SmartRoutine

SmartRoutine é um aplicativo Flutter para organizar tarefas diárias, acompanhar o percentual de conclusão e receber recomendações simples de melhoria da rotina. O projeto foi desenvolvido para o desafio anual SMART HAS da FIAP, no contexto de Sociedade 5.0.

## Problema e objetivo

Estudantes e profissionais com rotinas intensas podem perder visibilidade sobre prioridades, adiar atividades e perceber a rotina como desorganizada. O MVP transforma tarefas em uma lista objetiva, mostra o progresso diário e oferece uma orientação baseada no percentual concluído.

## Funcionalidades do MVP

- cadastro de tarefas;
- conclusão e exclusão de tarefas;
- persistência local no dispositivo;
- estatísticas de total, concluídas e percentual;
- recomendação baseada em regras de desempenho;
- navegação por Material 3.

## Arquitetura

O aplicativo é local e não depende de backend. A interface Flutter mantém o estado da sessão, serializa as tarefas em JSON e usa `shared_preferences` para persistência. O módulo de recomendação calcula a proporção de tarefas concluídas e seleciona uma orientação por faixa.

```text
Usuário -> Interface Flutter -> Estado e regras -> SharedPreferences -> armazenamento local
                                   |
                                   +-> Estatísticas e recomendação
```

Não há autenticação, sincronização em nuvem, coleta de dados pessoais em servidor ou modelo de machine learning nesta versão.

## Tecnologias

- Dart e Flutter;
- Material 3;
- pacote `shared_preferences`;
- Android Studio ou VS Code;
- Git e GitHub;
- `flutter_test` para testes de interface.

## Como executar

Pré-requisitos: Flutter compatível com Dart 3.11 ou superior e um emulador ou dispositivo configurado.

```bash
flutter pub get
flutter run
```

Para executar as verificações:

```bash
flutter analyze
flutter test
```

## Estrutura principal

```text
lib/main.dart          aplicação, modelo Task, persistência, telas e regras
test/widget_test.dart  testes de abertura, cadastro e conclusão de tarefa
docs/                  documentação técnica e roteiro de apresentação
```

## Regras de recomendação

| Condição | Orientação exibida |
|---|---|
| Nenhuma tarefa | Criar de três a cinco tarefas pequenas |
| Menos de 40% | Reduzir escopo, dividir tarefas grandes e priorizar |
| De 40% a 79% | Definir horário e começar pela tarefa mais importante |
| 80% ou mais | Manter o ritmo e incluir pausas |

## Limitações e evolução

O uso de `shared_preferences` atende ao protótipo, mas não é indicado para dados críticos nem para consultas complexas. Uma evolução de produto deve considerar banco local estruturado, sincronização em nuvem, autenticação, notificações, integração com calendário, métricas históricas, acessibilidade e recomendações personalizadas com consentimento do usuário.

## Autor

Lucas Fen Avelino - RM 556647 - Sistemas de Informação - FIAP - 2026.

## Repositório

https://github.com/LucasFen101/smartroutine
