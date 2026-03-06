import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "contacts.db");

    if (!await File(path).exists()) {

      ByteData data = await rootBundle.load("assets/contacts.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }
}