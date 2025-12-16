import 'package:flutter/material.dart';
import 'package:saved_place/saved_place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SavedPlace(),
    );
  }
}