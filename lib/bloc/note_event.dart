import 'package:note_2_flutter/note_model.dart';

abstract class NoteEvent{}

class FetchNoteEvent extends NoteEvent{}

class AddNoteEvent extends NoteEvent{
  NoteModel newNote;
  AddNoteEvent({required this.newNote});
}

class DeleteNoteEvent extends NoteEvent{
  int id;
  DeleteNoteEvent({required this.id});
}

class UpdateNoteEvent extends NoteEvent {
  NoteModel updateNote;

  UpdateNoteEvent({required this.updateNote});
}