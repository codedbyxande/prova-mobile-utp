import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/main.dart';

void main() {
  testWidgets('Verifica se nome do artista e ícones aparecem na tela', (WidgetTester tester) async {
    await tester.pumpWidget(const PerfilArtistaApp());
    await tester.pumpAndSettle();

    expect(find.text('Nome do Artista'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.album), findsNWidgets(3));
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.person_add_alt_1), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });
}
