import 'package:drift/drift.dart';

class Vehicles extends Table {
  IntColumn get id => integer()();
  TextColumn get plate => text()();
  TextColumn get label => text()();
  TextColumn get statusColor => text()();
  TextColumn get latitude => text()();
  TextColumn get longitude => text()();

  @override
  Set<Column> get primaryKey => {id};
}
