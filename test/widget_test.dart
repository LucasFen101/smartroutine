import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smartroutine/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('abre a tela de tarefas sem dados', (tester) async {
    await tester.pumpWidget(const SmartRoutineApp());
    await tester.pumpAndSettle();

    expect(find.text('SmartRoutine'), findsOneWidget);
    expect(find.textContaining('Nenhuma tarefa'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('adiciona e conclui uma tarefa', (tester) async {
    await tester.pumpWidget(const SmartRoutineApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Revisar relatório');
    await tester.tap(find.text('Adicionar'));
    await tester.pumpAndSettle();

    expect(find.text('Revisar relatório'), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Text>(find.text('Revisar relatório')).style?.decoration,
      TextDecoration.lineThrough,
    );
  });
}
