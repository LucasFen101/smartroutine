# Roteiro de vídeo do SmartRoutine

## Duração sugerida

De cinco a sete minutos.

## Abertura

Olá, meu nome é Lucas Fen Avelino, RM 556647, do curso de Sistemas de Informação da FIAP. Neste vídeo apresento o SmartRoutine, um aplicativo mobile criado no desafio SMART HAS para ajudar estudantes e profissionais a organizar tarefas e acompanhar sua produtividade.

## Problema e contexto

O projeto parte de uma dor cotidiana: quando as tarefas ficam espalhadas ou apenas na memória, a pessoa perde prioridades, procrastina e sente maior sobrecarga. A proposta se conecta à Sociedade 5.0 porque usa tecnologia de forma centrada no ser humano para apoiar organização e bem-estar.

## Solução

O SmartRoutine permite cadastrar, concluir e excluir tarefas. O aplicativo calcula o percentual de conclusão e apresenta uma recomendação baseada no desempenho do usuário. Nesta versão, a inteligência é baseada em regras transparentes e não em um modelo de machine learning.

## Demonstração

Na tela de tarefas, vou cadastrar a atividade “Revisar relatório final”. Depois, marco a tarefa como concluída. Na aba de estatísticas, o aplicativo mostra o total, a quantidade concluída e o percentual. Na aba Smart, a recomendação muda conforme a faixa de produtividade. Se eu fechar e abrir o aplicativo, as tarefas permanecem porque são salvas localmente no dispositivo.

## Tecnologia e arquitetura

O aplicativo foi desenvolvido com Dart e Flutter, usa Material 3 na interface e `shared_preferences` para persistência local em formato JSON. O MVP funciona offline e não exige servidor, autenticação ou API externa. O código foi versionado com Git e GitHub.

## Metodologia e validação

O desenvolvimento seguiu uma abordagem incremental, inspirada em Design Thinking e organizada por um quadro Kanban. Primeiro foi definido o problema, depois o fluxo mínimo e, por fim, o protótipo funcional. A validação técnica cobre abertura do aplicativo, cadastro, conclusão, persistência, estatísticas e regras de recomendação.

## Resultados e próximos passos

O MVP atingiu o objetivo de demonstrar um fluxo completo de organização pessoal com baixo custo operacional. Com mais tempo, eu adicionaria notificações, calendário, histórico, autenticação e sincronização em nuvem. Uma evolução com IA poderia personalizar recomendações, desde que os dados fossem coletados com consentimento e proteção de privacidade.

## Encerramento

O SmartRoutine demonstra que uma solução simples pode transformar tarefas em informação acionável e servir de base para um produto mais completo. Obrigado pela atenção.
