import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        name TEXT,
        password TEXT,
        address TEXT,
        contact TEXT PRIMARY KEY NOT NULL,
        state TEXT
      )
      """);
  }

  static Future<int> getLogin(String contact, String password) async {
    final db = await SQLHelper.db();
    var res = await db.rawQuery(
        "SELECT name FROM users WHERE contact = '$contact' and password = '$password'");
    if (res.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  static Future<void> setSession(String contact) async {
    final db = await SQLHelper.db();
    await db.rawQuery(
        "UPDATE users SET state = 'active' WHERE contact = '$contact'");
  }

  static Future<int> checkLogin() async {
    final db = await SQLHelper.db();
    var res = await db.rawQuery("SELECT * FROM users WHERE state = 'active'");
    if (res.isNotEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  static Future<void> logout() async {
    final db = await SQLHelper.db();
    await db.rawQuery("UPDATE users SET state = 'none' WHERE state = 'active'");
  }

  static Future<String> getName() async {
    final db = await SQLHelper.db();
    var res =
        await db.rawQuery("SELECT name FROM users WHERE state = 'active'");
    String name = res.toString();
    String namewithoutbraces =
        name.replaceAll(RegExp(r"\p{P}", unicode: true), "");
    String namewithouterror = namewithoutbraces.replaceAll("name", "");

    return namewithouterror;
  }

  static Future<String> getContact() async {
    final db = await SQLHelper.db();
    var res =
        await db.rawQuery("SELECT contact FROM users WHERE state = 'active'");
    String name;
    return name = res.toString();
  }

  static Future<String> getAddress() async {
    final db = await SQLHelper.db();
    var res =
        await db.rawQuery("SELECT address FROM users WHERE state = 'active'");
    String name;
    return name = res.toString();
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'master.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String name, String password, String address, String contact) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'password': password,
      'address': address,
      'contact': contact,
      'state': 'none'
    };
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
}
