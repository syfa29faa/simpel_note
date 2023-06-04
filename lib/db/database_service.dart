import 'package:hive/hive.dart';
import 'package:simple_note_app/models/note.dart';

class DatabaseService {
   static const boxName = 'note';

  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.add(note);
  }

  Future<void> editNote(int key, Note note) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, note);
  }

  Future<List<Note>> getNote() async {
    final box = await Hive.openBox(boxName);
    return box.values.toList().cast<Note>();
  }

  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox(boxName);
    box.delete(note.key);
  }
}



// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseService {
//   DatabaseService._();

//   static final db = DatabaseService._();

//   static Database? _database;

//   // Getter Database
//   Future<Database?> get database async {
//     // Check database available or not

//     if (_database != null) {
//       return _database;
//     }

//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     return await openDatabase(
//       join(await getDatabasesPath(), 'notes.db'),
//       version: 1,
//       onCreate: (db, version) async {
//         // Create Database
//         db.execute('''  
//         CREATE TABLE notes(id INTENGER PRIMARY KEY AUTOINCREMENT, 
//         title TEXT, 
//         description TEXT, 
//         createdAt DATE) 
//       ''');
//       },
//     );
//   }
// }
