import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/auth/data/datasource/local/models/users.dart';
import 'package:drift/drift.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(AppDatabase db) : super(db);

  Future<User?> getUser() => select(users).getSingleOrNull();

  Future<void> insertUser(UsersCompanion user) async {
    await into(users).insertOnConflictUpdate(user);
  }

  Future<void> clearUser() async {
    await delete(users).go();
  }
}
