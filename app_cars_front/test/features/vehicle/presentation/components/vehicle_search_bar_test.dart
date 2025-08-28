import 'package:app_cars_front/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VehicleSearchBar renders and calls onChanged callback', (
    WidgetTester tester,
  ) async {
    String? changedText;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VehicleSearchBar(
            onChanged: (value) {
              changedText = value;
            },
          ),
        ),
      ),
    );

    // Verify the TextField is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify the label text and hint
    expect(find.text('Buscar vehículo'), findsOneWidget);
    expect(find.text('Buscar vehículo por placa...'), findsOneWidget);

    // Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'ABC123');
    await tester.pumpAndSettle();

    // Verify the onChanged callback was called with correct value
    expect(changedText, 'ABC123');

    // Verify the prefix icon (search icon) exists
    final iconFinder = find.byIcon(Icons.search);
    expect(iconFinder, findsOneWidget);
  });
}
