import 'package:flutter/material.dart';
import 'package:my_place/my_place.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyPlace());
  }
}