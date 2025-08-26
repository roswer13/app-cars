import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ButtonBase', () {
    testWidgets('renders with given text', (WidgetTester tester) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(onPressed: () {}, text: 'Test Button'),
        ),
      );
      // Assert
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped and not disabled/loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      var pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(
            onPressed: () {
              pressed = true;
            },
            text: 'Tap Me',
          ),
        ),
      );
      // Assert
      await tester.tap(find.byType(MaterialButton));
      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when isDisabled is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      var pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(
            onPressed: () {
              pressed = true;
            },
            text: 'Disabled',
            isDisabled: true,
          ),
        ),
      );
      // Assert
      await tester.tap(find.byType(MaterialButton));
      expect(pressed, isFalse);
    });

    testWidgets('shows CircularProgressIndicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(onPressed: () {}, text: 'Loading', isLoading: true),
        ),
      );
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('does not call onPressed when isLoading is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      var pressed = false;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(
            onPressed: () {
              pressed = true;
            },
            text: 'Loading',
            isLoading: true,
          ),
        ),
      );
      // Assert
      await tester.tap(find.byType(MaterialButton));
      expect(pressed, isFalse);
    });

    testWidgets('applies custom width', (WidgetTester tester) async {
      // Arrange
      const customWidth = 200.0;
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: ButtonBase(
            onPressed: () {},
            text: 'Width Test',
            width: customWidth,
          ),
        ),
      );

      final materialButton = tester.widget<MaterialButton>(
        find.byType(MaterialButton),
      );
      // Assert
      expect(materialButton.minWidth, customWidth);
    });
  });
}
