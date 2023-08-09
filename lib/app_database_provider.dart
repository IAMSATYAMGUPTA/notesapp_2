import 'package:flutter/cupertino.dart';
import 'package:note_2_flutter/app_database.dart';
import 'package:note_2_flutter/note_model.dart';

class DatabaseProvider extends ChangeNotifier{

  AppDataBase myDB = AppDataBase.db;

  List<NoteModel> _noteList = [];

  List<NoteModel> get noteList => _noteList;

  void fetchNote()async{
    _noteList = await myDB.fetchAllNotes();
    notifyListeners();
  }

}