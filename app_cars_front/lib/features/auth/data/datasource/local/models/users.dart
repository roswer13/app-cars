import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get account => text()();
  TextColumn get phone => text()();

  @override
  Set<Column> get primaryKey => {account};
}
