import 'dart:async';

import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:term_proj2/src/model/item.dart';

import '../provider/shopping_provider.dart';

class SqliteModel {
  var logger = Logger();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    String path = join(await getDatabasesPath(), 'malone.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _database;
  }

  FutureOr<void> _onCreate(Database db, int version) {
    logger.d('onCreate');
    String sql = '''
    CREATE TABLE itemTable(
      itemCategory TEXT,
      name TEXT PRIMARY KEY,
      enrollDate TEXT,
      expireDate TEXT,
      notificationDate TEXT,
      count INTEGER,
      memo TEXT,
      storageCategory TEXT,
      image TEXT
     )
  ''';
    db.execute(sql);
    String sql2 = '''
    CREATE TABLE shoppingTable(
      name TEXT PRIMARY KEY,
      isSelected BOOLEAN
    )
  ''';
    db.execute(sql2);
  }

  // CRUD 형식

  Future<void> insertItem(Item item) async {
    final db = await database;

    await db?.insert(
      'itemTable', //테이블 명
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //기본키 중복시 대체
    );

    logger.d('insertItem ${item.name}');
  }

  Future<void> insertShopping(Shopping shopping) async {
    final db = await database;

    await db?.insert(
      'shoppingTable', //테이블 명
      shopping.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //기본키 중복시 대체
    );

    logger.d('insertshopping ${shopping.name}');
  }

  Future<List<Item>> getAllItemList() async {
    final db = await database;

    // 모든 itemList 쿼리
    final List<Map<String, Object?>>? maps = await db?.query('itemTable');

    logger.d('getAllItemList() ${maps!.length}개');

    // List<Map<String, dynamic>를 List<AssetPortfolio>으로 변환합니다.
    return List.generate(maps!.length, (i) {
      return Item(
        itemCategory: maps[i]['itemCategory'] as String,
        image: maps[i]['image'] as String,
        storageCategory: maps[i]['storageCategory'] as String,
        memo: maps[i]['memo'] as String,
        expireDate: maps[i]['expireDate'] as String,
        enrollDate: maps[i]['enrollDate'] as String,
        count: maps[i]['count'] as int,
        name: maps[i]['name'] as String,
        notificationDate: maps[i]['notificationDate'] as String
      );
    });
  }

  Future<List<Shopping>> getAllShoppingList() async {
    final db = await database;

    // 모든 itemList 쿼리
    final List<Map<String, Object?>>? maps = await db?.query('shoppingTable');

    logger.d('getAllshoppingList() ${maps!.length}개');
    // List<Map<String, dynamic>를 List<AssetPortfolio>으로 변환합니다.
    return List.generate(maps!.length, (i) {
      return Shopping(
        name: maps[i]['name'] as String,
        isSelected: maps[i]['isSelected'] == 0 ? false : true
      );
    });
  }

  Future<void> deleteItem(String name) async {
    final db = await database;

    // 데이터베이스에서 AssetPortfolio를 삭제합니다.
    await db!.delete(
      'itemTable',
      where: "name = ?",
      whereArgs: [name],
    );

    logger.d('deleteItem() $name');
  }

  Future<void> deleteShopping(String name) async {
    final db = await database;

    // 데이터베이스에서 AssetPortfolio를 삭제합니다.
    await db!.delete(
      'shoppingTable',
      // 특정 AssetPortfolio를 제거하기 위해 `where` 절을 사용하세요
      where: "name = ?",
      whereArgs: [name],
    );

    logger.d('deletShopping() $name');
  }

}