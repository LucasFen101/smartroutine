# Arquitetura e casos de uso do SmartRoutine

## Visão de arquitetura

O MVP adota uma arquitetura local e monolítica adequada à validação inicial. A camada de apresentação foi construída com widgets Flutter e Material 3. A classe de estado da página principal coordena as tarefas, os cálculos de produtividade e a persistência. Cada tarefa é serializada em JSON e armazenada como uma lista no `shared_preferences`.

## Componentes

| Componente | Responsabilidade | Tecnologia |
|---|---|---|
| Interface | Exibir tarefas, estatísticas e recomendações | Flutter e Material 3 |
| Estado da aplicação | Coordenar cadastro, conclusão, exclusão e navegação | Dart e StatefulWidget |
| Modelo de tarefa | Representar título, status e data de criação | Classe Task em Dart |
| Persistência | Gravar e recuperar a lista serializada | shared_preferences e JSON |
| Regras | Calcular percentual e selecionar recomendação | Funções determinísticas em Dart |

## Casos de uso

### Cadastrar tarefa

O usuário abre o diálogo, informa um título e confirma. O aplicativo valida se o texto não está vazio, adiciona a tarefa ao estado e persiste a nova lista.

### Concluir ou reabrir tarefa

O usuário toca na caixa de seleção. O aplicativo alterna o status, recalcula as estatísticas e salva o estado.

### Excluir tarefa

O usuário toca no ícone de lixeira. A tarefa é removida e a lista atualizada é persistida.

### Consultar produtividade

O aplicativo divide o número de tarefas concluídas pelo total e apresenta total, concluídas e percentual. Quando não há tarefas, o percentual é zero.

### Receber recomendação

O aplicativo classifica o percentual em uma das faixas definidas no MVP e exibe uma orientação. Trata-se de inferência por regras, sem treinamento de modelo ou envio de dados a serviços externos.

## Requisitos não funcionais do MVP

- funcionamento offline;
- resposta imediata para as operações locais;
- interface compreensível em telas de celular;
- persistência após reinício do aplicativo;
- ausência de dependência de API externa;
- tratamento de conteúdo local inválido, retornando uma lista vazia.

## Decisões e restrições

O armazenamento local reduz custo e complexidade, mas não oferece sincronização entre dispositivos. O estado concentrado em um arquivo facilita o protótipo, porém deve ser separado em camadas e repositórios se o produto crescer. Dados sensíveis e históricos extensos não devem ser mantidos em `shared_preferences`.
