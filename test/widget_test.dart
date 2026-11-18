// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanitas_app/main.dart';

void main() {
  testWidgets('SanitasApp navigation and app bar test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProntuarioFamiliarApp());

    // Verify app name 'SANITAS' is present in AppBar
    expect(find.text('SANITAS'), findsWidgets);

    // Verify initial screen title 'Visão Geral' is present
    expect(find.text('Visão Geral'), findsOneWidget);

    // Tap 'Exames' bottom navigation item
    await tester.tap(find.text('Exames'));
    await tester.pumpAndSettle();

    // Verify 'Meus Exames' screen title is present
    expect(find.text('Meus Exames'), findsOneWidget);

    // Tap 'Perfil' bottom navigation item
    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    // Verify 'Perfil e Saúde' screen title is present
    expect(find.text('Perfil e Saúde'), findsOneWidget);
  });
}
