import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  testWidgets('VehicleItem displays label and green status', (
    WidgetTester tester,
  ) async {
    final vehicle = VehicleResult(
      id: 1,
      plate: 'AAA123',
      label: 'Test',
      statusColor: 'green',
      latitude: '10.0',
      longitude: '20.0',
    );
    await tester.pumpWidget(makeTestableWidget(VehicleItem(item: vehicle)));

    expect(find.text('Test'), findsOneWidget);

    final circle = tester.widget<Container>(
      find
          .descendant(of: find.byType(Row), matching: find.byType(Container))
          .last,
    );
    final decoration = circle.decoration as BoxDecoration;
    expect(decoration.color, Colors.green);
    expect(decoration.shape, BoxShape.circle);
  });

  testWidgets('VehicleItem displays blue status', (WidgetTester tester) async {
    final vehicle = VehicleResult(
      id: 1,
      plate: 'AAA123',
      label: 'Test',
      statusColor: 'blue',
      latitude: '10.0',
      longitude: '20.0',
    );
    await tester.pumpWidget(makeTestableWidget(VehicleItem(item: vehicle)));

    final circle = tester.widget<Container>(
      find
          .descendant(of: find.byType(Row), matching: find.byType(Container))
          .last,
    );
    final decoration = circle.decoration as BoxDecoration;
    expect(decoration.color, Colors.blue);
  });

  testWidgets('VehicleItem displays black status', (WidgetTester tester) async {
    final vehicle = VehicleResult(
      id: 1,
      plate: 'AAA123',
      label: 'Test',
      statusColor: 'black',
      latitude: '10.0',
      longitude: '20.0',
    );
    await tester.pumpWidget(makeTestableWidget(VehicleItem(item: vehicle)));

    final circle = tester.widget<Container>(
      find
          .descendant(of: find.byType(Row), matching: find.byType(Container))
          .last,
    );
    final decoration = circle.decoration as BoxDecoration;
    expect(decoration.color, Colors.black);
  });

  testWidgets('VehicleItem displays red status', (WidgetTester tester) async {
    final vehicle = VehicleResult(
      id: 1,
      plate: 'AAA123',
      label: 'Test',
      statusColor: 'red',
      latitude: '10.0',
      longitude: '20.0',
    );
    await tester.pumpWidget(makeTestableWidget(VehicleItem(item: vehicle)));

    final circle = tester.widget<Container>(
      find
          .descendant(of: find.byType(Row), matching: find.byType(Container))
          .last,
    );
    final decoration = circle.decoration as BoxDecoration;
    expect(decoration.color, Colors.red);
  });

  testWidgets('VehicleItem displays red status for unknown color', (
    WidgetTester tester,
  ) async {
    final vehicle = VehicleResult(
      id: 1,
      plate: 'AAA123',
      label: 'Test',
      statusColor: 'pink',
      latitude: '10.0',
      longitude: '20.0',
    );
    await tester.pumpWidget(makeTestableWidget(VehicleItem(item: vehicle)));

    final circle = tester.widget<Container>(
      find
          .descendant(of: find.byType(Row), matching: find.byType(Container))
          .last,
    );
    final decoration = circle.decoration as BoxDecoration;
    expect(decoration.color, Colors.red);
  });
}
