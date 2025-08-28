import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicles.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

part 'vehicles_test.g.dart';

LazyDatabase _openTestConnection() {
  return LazyDatabase(() async {
    return NativeDatabase.memory();
  });
}

@DriftDatabase(tables: [Vehicles])
class TestDatabase extends _$TestDatabase {
  TestDatabase() : super(_openTestConnection());

  @override
  int get schemaVersion => 1;
}

void main() {
  late TestDatabase db;

  setUp(() {
    db = TestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  test('can insert and read a vehicle', () async {
    // Insert a vehicle
    final vehicle = VehiclesCompanion.insert(
      id: Value(1),
      plate: 'ABC123',
      label: 'Car 1',
      statusColor: 'green',
      latitude: '12.34',
      longitude: '56.78',
    );

    await db.into(db.vehicles).insert(vehicle);

    // Read it back
    final fetched = await (db.select(
      db.vehicles,
    )..where((v) => v.id.equals(1))).getSingle();

    expect(fetched.id, 1);
    expect(fetched.plate, 'ABC123');
    expect(fetched.label, 'Car 1');
    expect(fetched.statusColor, 'green');
    expect(fetched.latitude, '12.34');
    expect(fetched.longitude, '56.78');
  });

  test('primary key enforces uniqueness', () async {
    final vehicle = VehiclesCompanion.insert(
      id: Value(1),
      plate: 'ABC123',
      label: 'Car 1',
      statusColor: 'green',
      latitude: '12.34',
      longitude: '56.78',
    );

    await db.into(db.vehicles).insert(vehicle);

    // Attempt to insert another vehicle with the same id should fail
    final duplicate = VehiclesCompanion.insert(
      id: Value(1),
      plate: 'XYZ789',
      label: 'Car 2',
      statusColor: 'red',
      latitude: '56.78',
      longitude: '90.12',
    );

    expect(
      () async => await db.into(db.vehicles).insert(duplicate),
      throwsA(isA<SqliteException>()),
    );
  });
}
