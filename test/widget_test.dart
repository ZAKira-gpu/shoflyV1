// This is a basic Flutter widget test for Chauffly app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shofly_v/main.dart';

void main() {
  testWidgets('Chauffly app loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
