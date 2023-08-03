import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_2_flutter/create_note.dart';
import 'package:note_2_flutter/tile.dart';

import 'app_database.dart';
import 'note_model.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var height = [180.0,180.0,180.0,260.0,180.0,260.0,180.0];
  final List colorList = [Colors.orangeAccent.shade200,Colors.yellow.shade100,Colors.lightGreen.shade200,
    Colors.blue.shade100,Colors.pink.shade100,Colors.purple.shade100,Colors.red.shade300];

  late AppDataBase myDB;
  List<NoteModel> arrNotes = [];

  @override
  void initState() {
    super.initState();
    myDB = AppDataBase.db;
    getNotes();
  }

  void getNotes() async {
    arrNotes = await myDB.fetchAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 30),),
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(Icons.search,color: Colors.white,size: 27,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white30,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                padding: EdgeInsets.only(left: 10,right: 10),
                itemCount: arrNotes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotePage(title: arrNotes[index].title,desc: arrNotes[index].desc,date: arrNotes[index].date,id : arrNotes[index].id),));
                    },
                    child: Container(
                      height: height[index % height.length],
                      decoration: BoxDecoration(
                          color: colorList[index % colorList.length ],
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(1,-1),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.black,
                              onPressed: (){
                                myDB.deleteNote(arrNotes[index].id!);
                                getNotes();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(arrNotes[index].desc,style: TextStyle(fontSize: 23),softWrap: true,maxLines: 4,overflow: TextOverflow.ellipsis,),
                                Text(arrNotes[index].date,style: TextStyle(fontSize: 18),),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index){
                  return StaggeredTile.fit(index%7==2 ? 2:1);
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        focusElevation: 2.0,
        backgroundColor: Color(0xff1776b9),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotePage(),));
        },
        child: Icon(Icons.add,color: Colors.white,),
        
      ),
    );
  }
}