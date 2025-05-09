import 'dart:io';

import 'package:demo/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  Future<Database> get db async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = "${directory.path}/neak_it.db";
      return await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) => _createTable(db),
        onUpgrade: (db, oldVersion, newVersion) async {
          var batch = db.batch();
          if (oldVersion == 1) {
            _updateTableV1toV2(batch);
          }
          await batch.commit();
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void _createTable(Database db) async {
    final batch = db.batch();
    batch.execute(
        "CREATE TABLE ${UserModel.tableName} (uid INTEGER PRIMARY KEY, id TEXT, firstName TEXT,lastName TEXT,gender TEXT,phone TEXT,email TEXT,bio TEXT,profile TEXT,token TEXT, profileCover TEXT DEFAULT '')");

    // Insert the initial record
    batch.execute('''
                INSERT INTO ${UserModel.tableName} (
                  uid, id, firstName, lastName, gender, phone, email, bio, profile, token, profileCover
                ) VALUES (
                  1, 'MQ==', 'Luon', 'Verak', 'Male', '0765654529', 'luonverakcambo@gmail.com', '',
                  'http://10.0.2.2:8000/uploads/user/01Jan2025110146-photo_2023-03-02_17-07-30.jpg',
                  '75fc340cdb91a374450a20ea0795b1ad66ffd310'
                )
                ''');
    batch.commit();
  }

  void _updateTableV1toV2(Batch batch) {
   // batch.execute('ALTER TABLE ${UserModel.tableName} ADD COLUMN profileCover TEXT DEFAULT ""');
  }
}
