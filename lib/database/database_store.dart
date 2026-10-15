import 'package:exenzia/model/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('transactions.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transaction_type TEXT NOT NULL,
            name TEXT NOT NULL,
            amount REAL NOT NULL,
            date TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT
  Future<int> insertTransaction(TransactionModel item) async {
    final db = await instance.database;

    return await db.insert(
      'transactions',
      item.toMap(),
    );
  }

  // GET ALL
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await instance.database;

    final result = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );

    return result
        .map((map) => TransactionModel.fromMap(map))
        .toList();
  }

  // GET BY ID
  Future<TransactionModel?> getTransactionById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TransactionModel.fromMap(maps.first);
    }

    return null;
  }

  // UPDATE
  Future<int> updateTransaction(TransactionModel item) async {
    final db = await instance.database;

    return await db.update(
      'transactions',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // DELETE
  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;

    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}