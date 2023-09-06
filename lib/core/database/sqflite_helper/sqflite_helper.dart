import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';

class SqfliteHelper {
  late Database db;

  Future<Database> initDB() async {
    return await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            notes TEXT,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            color INTEGER,
            isCompleted INTEGER)
        ''').then((value) => print('DB created successfully'));
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  Future<int> insertToDB(TaskModel taskModel) async {
    return await db.rawInsert('''
      INSERT INTO Tasks 
        (title, notes, date, startTime, endTime, color, isCompleted) 
        VALUES(?,?,?,?,?,?,?)
    ''', [
      '${taskModel.title}',
      '${taskModel.note}',
      '${taskModel.date}',
      '${taskModel.startTime}',
      '${taskModel.endTime}',
      taskModel.color,
      taskModel.isComoleted,
    ]);
  }

  Future<int> updatedDB(int id) async {
    return await db.rawUpdate(
        'UPDATE Tasks SET isCompleted = ? WHERE id = ?', ['1', '$id']);
  }

  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']);
  }
}
