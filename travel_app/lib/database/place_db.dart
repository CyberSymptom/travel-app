import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class PlaceDB {



static Future<sql.Database> database() async {

final dbpath = await sql.getDatabasesPath();
    return await await sql.openDatabase(
      path.join(dbpath, "places.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
      },
      version: 1,
    );
  
}





  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDB = await PlaceDB.database();
  }


  static Future<List<Map<String, dynamic>>> getDate(String table) async{

    final sqlDB = await PlaceDB.database();
   return sqlDB.query(table);

  }
}
