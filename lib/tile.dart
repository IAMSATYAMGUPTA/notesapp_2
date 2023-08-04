import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int index;

  Tile({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Replace this with the desired color or other widgets for your tiles.
      child: Center(
        child: Text(
          'Tile $index',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
// satyam gupta sadfkdsnm
