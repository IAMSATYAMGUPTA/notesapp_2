import 'dart:io';

import 'package:note_2_flutter/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{

  AppDataBase._();

  static final AppDataBase db = AppDataBase._();

  Database? _database;

  static final NOTE_TABLE = "note2";
  static final NOTE_COLUMN_ID = "id";
  static final NOTE_COLUMN_TITLE = "title";
  static final NOTE_COLUMN_DESC = "desc";
  static final NOTE_COLUMN_DATE = "date";

  Future<Database> getDB()async{
    if(_database!=null){
      return _database!;
    }
    else{
      return await initDB();
    }
  }

  Future<Database> initDB()async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(documentDirectory.path,"mynote.db");

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE $NOTE_TABLE ("
            "$NOTE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$NOTE_COLUMN_TITLE TEXT, "
            "$NOTE_COLUMN_DESC TEXT, "
            "$NOTE_COLUMN_DATE TEXT "
            ")");
      },
    );
  }

  Future<bool> addNote(NoteModel note)async{

    var db = await getDB();

    var check = await db.insert(NOTE_TABLE, note.toMap());

    return check>0;
  }

  Future<List<NoteModel>> fetchAllNotes()async{

    var db = await getDB();

    List<Map<String,dynamic>> notes = await db.query(NOTE_TABLE);

    List<NoteModel> listNotes = [];
    
    for(Map<String,dynamic> map in notes){
      listNotes.add(NoteModel.fromMap(map));
    }

    return listNotes;
    
  }

  Future<bool>  updateNote(NoteModel note)async{

    var db = await getDB();

    var count = await db.update(NOTE_TABLE, note.toMap(),where: "$NOTE_COLUMN_ID = ?",whereArgs: ['${note.id}']);

    return count>0;

  }

  Future<bool> deleteNote(int id)async{

    var db = await getDB();

    var count = await db.delete(NOTE_TABLE, where: "$NOTE_COLUMN_ID = ?",whereArgs: ['$id']);

    return count>0;

  }

}