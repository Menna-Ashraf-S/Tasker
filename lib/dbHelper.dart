import 'package:flutter_pro/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper () => _instance ;
  DbHelper.internal();
  static  Database ? _db ;

  Future createDatabase () async {
    if(_db != null ){
      return _db ;
    }
    String path = join (await getDatabasesPath() , 'Tasker.db') ; 
     _db = await openDatabase( path , version: 1 , onCreate: (Database db,  int version) {
      db.execute('create table tasks (id integer primary key autoincrement , name varchar(200) , due_date varchar(200) , date varchar(200))' );
    },
     );
     return _db ;
     }
    Future <int> createTask (Task task) async{
      Database db = await createDatabase() ;
      return db.insert('tasks', task.toMap() );
     }

     Future <List> allTasks ()async{
      Database db = await createDatabase() ;
      return db.query('tasks');
     }

     Future <int> delete (int id) async{
      Database db = await createDatabase() ;
      return db.delete('tasks' , where: 'id = ?', whereArgs: [id]);
     }
}