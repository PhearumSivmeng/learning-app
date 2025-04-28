import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/services/db_service.dart';
import 'package:sqflite/sqflite.dart';

class Auth {
  Auth._();

  static final Auth instance = Auth._();

  static UserModel? _user;

  Future<UserModel?> get user async => _user ??= await _initAuth();

  Future<UserModel?> _initAuth() async {
    try {
      final db = await DB.instance.db;
      final user = await db.query(UserModel.tableName);
      if (user.isNotEmpty) {
        return UserModel.fromJson(
          user[0].map((key, value) => MapEntry(key, value ?? '')),
        );
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onResetAuth() async {
    _user = null;
  }

  Future<void> onSaveUser({required UserModel userModel}) async {
    try {
      final db = await DB.instance.db;
      await db.delete(UserModel.tableName);
      Auth.instance.onResetAuth();
      await db.insert(
        UserModel.tableName,
        userModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      var result = await db.query(UserModel.tableName);
      print(result);
    } catch (e) {
      rethrow;
    }
  }
}
