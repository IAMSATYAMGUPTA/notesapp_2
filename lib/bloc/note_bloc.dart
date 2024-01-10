// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:note_2_flutter/bloc/note_event.dart';
// import 'package:note_2_flutter/bloc/note_state.dart';
//
// import '../app_database.dart';
//
// class NoteBloc extends Bloc<NoteEvent,NoteState>{
//   AppDataBase db;
//   NoteBloc({required this.db}):super(NoteInitialState()) {
//     on<AddNoteEvent>((event, emit) async {
//       emit(NoteLoadingState());
//       bool check = await db.addNote(event.newNote);
//       if (check) {
//         var noteList = await db.fetchAllNotes();
//         emit(NoteLoadedState(arrNotes: noteList));
//       } else {
//         emit(NoteErrorState(errorMsg: "Note not Added!!"));
//       }
//     });
//
//     on<DeleteNoteEvent>((event, emit) {
//       db.deleteNote(event.id).then((value) {
//         fetchNote();
//       });
//     });
//
//     on<UpdateNoteEvent>((event, emit) {
//       db.updateNote(event.updateNote).then((value) {
//         fetchNote();
//       });
//     });
//   }
//
//   void fetchNote()async{
//     emit(NoteLoadingState());
//     var noteList = await db.fetchAllNotes();
//     emit(NoteLoadedState(arrNotes: noteList));
//   }
// }