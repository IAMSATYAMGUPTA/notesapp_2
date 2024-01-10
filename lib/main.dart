import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_2_flutter/app_database.dart';
import 'package:note_2_flutter/cubit/app_database_cubit.dart';
import 'package:note_2_flutter/provider/app_database_provider.dart';
import 'package:note_2_flutter/bloc/note_bloc.dart';
import 'package:provider/provider.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => DataBaseCubit(db: AppDataBase.db),
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
// ffdkkfnmdkmgrkf

