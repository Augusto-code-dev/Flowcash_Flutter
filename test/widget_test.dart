import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flowcash/main.dart'; // ⚠️ verifique se o nome do projeto no pubspec.yaml é o mesmo

void main() {
  testWidgets('Verifica se o título FlowCash aparece na tela inicial',
      (WidgetTester tester) async {
    // Inicializa o app
    await tester.pumpWidget(const MyApp());

    // Verifica se o texto "FlowCash" está presente
    expect(find.text('FlowCash'), findsOneWidget);

    // Verifica se o botão "Entrar" existe
    expect(find.text('Entrar'), findsOneWidget);

    // Verifica se o campo de usuário está presente
    expect(find.byType(TextField), findsNWidgets(2)); // usuário e senha
  });
}
