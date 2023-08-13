import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_2_flutter/app_database.dart';
import 'package:note_2_flutter/app_database_provider.dart';
import 'package:provider/provider.dart';

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

  void addNote({required String title,required String desc,required String currentDate}){
    context.read<DatabaseProvider>().addNote(NoteModel(title: title,desc: desc,date: currentDate));
  }

  void updateNote({required String title,required String desc,required String currentDate,required int id}){
    context.read<DatabaseProvider>().updateNote(NoteModel(title: title,desc: desc,date: currentDate,id: id));
  }


  @override
  Widget build(BuildContext context) {

    //----------------------check title value Null or Not------------------
    if(widget.date!=null){
      titleController.text = widget.title;
      descController.text = widget.desc;
    }

    // ------------------------------Get Current Date----------------------
    var date = DateTime.now();
    var currentDate = DateFormat.yMMMMd('en_US').format(date).toString();

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //-----------------------back Screen Arrow-----------------
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 37,
                      width: 37,
                      child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 22,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white30
                      ),
                    ),
                  ),


                  //-----------------------Save and update Note Work-----------------
                  InkWell(
                    onTap: widget.date!=null ? (){
                      updateNote(title: titleController.text.toString(), desc: descController.text.toString(), currentDate : currentDate,id: widget.id);
                      Navigator.pop(context);
                    }: (){
                      addNote(title: titleController.text.toString(),desc: descController.text.toString(),currentDate: currentDate);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 37,
                      width: widget.date!=null ? 40:70,
                      child: widget.date!=null ? Icon(Icons.update_outlined,color: Colors.white,size: 27,):
                      Center(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),)),
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

            //----------------------------add Title-----------------------------
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


            //----------------------------Show Date-----------------------------
            widget.date!=null ? Text("   ${widget.date}",style: TextStyle(color: Colors.grey,fontSize: 18),):Container(),
            SizedBox(height: 10,),


            //----------------------------add Desc-----------------------------
            TextField(
              controller: descController,
              maxLines: null,
              minLines: 20,
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
      ),
    );
  }
}
