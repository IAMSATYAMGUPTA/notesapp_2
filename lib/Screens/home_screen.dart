import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_2_flutter/cubit/app_database_cubit.dart';
import 'package:note_2_flutter/provider/app_database_provider.dart';
import 'package:note_2_flutter/bloc/note_bloc.dart';
import 'package:note_2_flutter/bloc/note_event.dart';
import 'package:note_2_flutter/bloc/note_state.dart';
import 'package:note_2_flutter/Screens/create_note.dart';
import 'package:note_2_flutter/cubit/cubit_state.dart';
import 'package:provider/provider.dart';

import '../app_database.dart';
import '../note_model.dart';

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

  // get provider refrrence for initial condition // also call fetch note fun in provider class
  void getNotes(){
    context.read<DataBaseCubit>().fetchNote();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          SizedBox(height: 30,),


          // ------------------ showing title and search bar-------------------
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


          BlocBuilder<DataBaseCubit,NoteState>(
            builder: (context, state) {
              if (state is NoteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteErrorState) {
                return Center(
                  child: Text(state.errorMsg),
                );
              } else if (state is NoteLoadedState) {
                arrNotes = state.arrNotes;
                return Expanded(
                  child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      mainAxisSpacing: 13,
                      crossAxisSpacing: 13,
                      padding: EdgeInsets.only(left: 7, right: 7),
                      itemCount: arrNotes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                CreateNotePage(title: arrNotes[index].title,
                                    desc: arrNotes[index].desc,
                                    date: arrNotes[index].date,
                                    id: arrNotes[index].id),));
                          },
                          child: Container(
                            height: height[index % height.length],
                            decoration: BoxDecoration(
                                color: colorList[index % colorList.length ],
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Stack(
                              children: [

                                // ------------------ showing delete button-------------------
                                Align(
                                  alignment: Alignment(
                                      index % 7 == 2 ? 1.06 : 1.15, -1.08),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.black54,
                                    onPressed: () {
                                      context.read<DataBaseCubit>().deleteNote(arrNotes[index].id!);
                                    },
                                  ),
                                ),


                                // ------------------ Notes List using staggered Gridview------------
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 15, 20, 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(arrNotes[index].desc,
                                        style: TextStyle(fontSize: 23),
                                        softWrap: true,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,),
                                      Text(arrNotes[index].date,
                                        style: TextStyle(fontSize: 18),),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.fit(index % 7 == 2 ? 2 : 1);
                      }),
                );
              }
              return Container();
          },)
        ],
      ),

      //------------------------Add Note Button-----------------------------
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        focusElevation: 2.0,
        backgroundColor: Color(0xff062f4d),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotePage(),));
        },
        child: Icon(Icons.add,color: Colors.white,),
        
      ),
    );
  }
}