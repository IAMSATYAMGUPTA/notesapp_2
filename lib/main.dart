import 'package:flutter/material.dart';
import 'package:note_2_flutter/app_database_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DatabaseProvider(),
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

