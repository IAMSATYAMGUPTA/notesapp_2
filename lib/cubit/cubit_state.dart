import '../note_model.dart';

abstract class NoteState{}

class NoteInitialState extends NoteState{}

class NoteLoadingState extends NoteState{}

class NoteLoadedState extends NoteState{
  List<NoteModel> arrNotes;
  NoteLoadedState({required this.arrNotes});
}

class NoteErrorState extends NoteState{
  String errorMsg;
  NoteErrorState({required this.errorMsg});
}
