import 'package:flutter/cupertino.dart';
import 'package:note_2_flutter/app_database.dart';
import 'package:note_2_flutter/note_model.dart';

class DatabaseProvider extends ChangeNotifier{

  AppDataBase myDB = AppDataBase.db;

  List<NoteModel> _noteList = [];


  // get all changes
  List<NoteModel> get noteList => _noteList;


  // add note database
  void addNote(NoteModel noteModel){
    myDB.addNote(noteModel).then((value) {
      fetchNote();
    });
  }

  // fetchNote database
  void fetchNote()async{
    _noteList = await myDB.fetchAllNotes();
    notifyListeners();
  }

  // delete database
  void deleteNote(int id){
    myDB.deleteNote(id).then((value) {
      fetchNote();
    });
  }

  // update database
  void updateNote(NoteModel noteModel){
    myDB.updateNote(noteModel).then((value) {
      fetchNote();
    });
  }

}