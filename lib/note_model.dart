import 'package:note_2_flutter/app_database.dart';

class NoteModel{

  int? id;
  String title;
  String desc;
  String date;

  NoteModel({this.id,required this.title,required this.desc,required this.date});

  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
      id : map[AppDataBase.NOTE_COLUMN_ID],
      title : map[AppDataBase.NOTE_COLUMN_TITLE],
      desc : map[AppDataBase.NOTE_COLUMN_DESC],
      date : map[AppDataBase.NOTE_COLUMN_DATE],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      AppDataBase.NOTE_COLUMN_ID : id,
      AppDataBase.NOTE_COLUMN_TITLE : title,
      AppDataBase.NOTE_COLUMN_DESC : desc,
      AppDataBase.NOTE_COLUMN_DATE : date,
    };

  }

}