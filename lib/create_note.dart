import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_2_flutter/app_database.dart';

import 'note_model.dart';

class CreateNotePage extends StatefulWidget {
  var id;
  var title;
  var desc;
  var date;
  CreateNotePage({this.title=null,this.desc=null,this.date=null,this.id=null});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {

  var titleController = TextEditingController();
  var descController = TextEditingController();
  late AppDataBase myDB;

  @override
  void initState() {
    super.initState();
    myDB = AppDataBase.db;
  }

  void addNote(String title,String desc,String currentDate)async{
    await myDB.addNote(NoteModel(title: title, desc: desc, date: currentDate));
  }

  @override
  Widget build(BuildContext context) {
    if(widget.date!=null){
      titleController.text = widget.title;
      descController.text = widget.desc;
    }
    var date = DateTime.now();
    var currentDate = DateFormat.yMMMMd('en_US').format(date).toString();
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 27,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white30
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.date!=null ? (){
                    myDB.updateNote(NoteModel(title: titleController.text.toString(), desc: descController.text.toString(), date: currentDate,id: widget.id));
                  }: (){
                    addNote(titleController.text.toString(), descController.text.toString(),currentDate);
                  },
                  child: Container(
                    height: 40,
                    width: widget.date!=null ? 40:90,
                    child: widget.date!=null ? Icon(Icons.update_rounded,color: Colors.white,size: 27,):
                    Center(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 26),)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white30
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: titleController,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 37),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 37),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
            ),
          ),
          widget.date!=null ? Text("   ${widget.date}",style: TextStyle(color: Colors.grey,fontSize: 18),):Container(),
          SizedBox(height: 10,),
          TextField(
            controller: descController,
            maxLines: null,
            style: TextStyle(color: Colors.white,fontSize: 19),
            decoration: InputDecoration(
              hintText: "Type Somethings...",
              hintStyle: TextStyle(color: Colors.grey,fontSize: 19),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              ),
            ),
          )
        ],
      ),
    );
  }
}
