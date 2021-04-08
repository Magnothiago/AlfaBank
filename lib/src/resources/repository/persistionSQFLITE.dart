import 'dart:async';

import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersistenceServiceSQL {
  static Database _database;

  PersistenceServiceSQL._privateConstructor();

  static final PersistenceServiceSQL instancia = PersistenceServiceSQL
      ._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), "alfabank.db");
    return openDatabase(
        path,
        onCreate: _onCreate,
        version: 1
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE usuarios("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "nome TEXT NOT NULL,"
            "cpf TEXT NOT NULL,"
            "email TEXT NOT NULL,"
            "telefone TEXT NOT NULL,"
            "senha TEXT NOT NULL)"
    );
  }

  Future<bool> insertUsuario(Usuario usuario) async {
    final Database db = await database;
    try {
      await db.insert(
          'usuarios',
          usuario.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      print("${e.toString()}");
      return false;
    }
  }

  Future<void> printAllUser() async {
    final Database db = await database;
    List<Map<String, Object>> usuarios = await db.query("usuarios", orderBy: "id");
    for (var item in usuarios) {
      print(unMap(item));
    }
    }

  Future<Usuario> findUsuarioByCPF(String cpf) async {
    final Database db = await database;
    Usuario u;
    List<Map<String, Object>> list = await db.query(
        'usuarios',
        where: '"cpf" = ''?',
        whereArgs: [cpf]);
    if (list.length > 1) return null;
    for (var item in list) {
      u = unMap(item);
    }
    return u;
  }
  Usuario unMap(Map<String, dynamic> usuario) {
    return Usuario(usuario['nome'], usuario['cpf'], usuario['email'], usuario['telefone'], usuario['senha']);
  }
}