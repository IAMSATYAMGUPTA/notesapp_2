import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_2_flutter/app_database.dart';
import 'package:note_2_flutter/cubit/cubit_state.dart';
import 'package:note_2_flutter/note_model.dart';

class DataBaseCubit extends Cubit<NoteState>{

  AppDataBase db;

  DataBaseCubit({required this.db}):super(NoteInitialState());

  List<NoteModel> notesData = [];

  // fetch note
  void fetchNote()async{
    emit(NoteLoadingState());
    notesData = await db.fetchAllNotes();
    emit(NoteLoadedState(arrNotes: notesData));
  }
  // add note
  void addNote(NoteModel newNote) async{
    //2
    emit(NoteLoadingState());
    bool check = await db.addNote(newNote);

    if(check){
      //3
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      //4
      emit(NoteErrorState(errorMsg: "Note not Added!"));
    }

  }

  // update note
  void updateNote(NoteModel noteModel)async{

    emit(NoteLoadingState());
    bool check = await db.updateNote(noteModel);

    if(check){
      //3
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      //4
      emit(NoteErrorState(errorMsg: "Note not Added!"));
    }

  }

  // delete Note
  void deleteNote(int id)async{

    emit(NoteLoadingState());

    bool check = await db.deleteNote(id);

    if(check){
      //3
      var notes = await db.fetchAllNotes();
      emit(NoteLoadedState(arrNotes: notes));
    } else {
      //4
      emit(NoteErrorState(errorMsg: "Note not Delete!"));
    }

  }


}