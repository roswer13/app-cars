import 'package:app_cars_front/core/db/app_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.test();
  });

  tearDown(() async {
    await database.close();
  });

  test('schemaVersion should be 1', () {
    expect(database.schemaVersion, 1);
  });

  test('insert and query a user', () async {
    final user = UsersCompanion.insert(account: 'test', phone: '1234567890');

    await database.into(database.users).insert(user);

    final result = await database.select(database.users).get();

    expect(result.length, 1);
    expect(result.first.account, 'test');
    expect(result.first.phone, '1234567890');
  });

  test('insert, update and delete vehicle', () async {
    final vehicle = VehiclesCompanion.insert(
      id: Value(1),
      plate: 'ABC123',
      label: 'My Car',
      statusColor: 'red',
      latitude: '37.7749',
      longitude: '-122.4194',
    );

    await database.into(database.vehicles).insert(vehicle);

    // Update
    await (database.update(database.vehicles)..where((tbl) => tbl.id.equals(1)))
        .write(VehiclesCompanion(label: Value('Honda')));

    final updated = await database.select(database.vehicles).get();
    expect(updated.first.label, 'Honda');

    // Delete
    await (database.delete(
      database.vehicles,
    )..where((tbl) => tbl.id.equals(1))).go();

    final afterDelete = await database.select(database.vehicles).get();
    expect(afterDelete, isEmpty);
  });
}
