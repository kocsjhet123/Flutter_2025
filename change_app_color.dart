import 'dart:math';

import 'package:flutter/material.dart';

class ChangeAppColor extends StatefulWidget {
  const ChangeAppColor({super.key});

  @override
  State<ChangeAppColor> createState() => _ChangeAppColorState();
}

class _ChangeAppColorState extends State<ChangeAppColor> {
  late Color currentColor = Colors.purple;
  List<Color> colors = [
    Colors.purple,
    Colors.blueGrey,
    Colors.pink,
    Colors.green,
  ];

  @override
  void initState() {
    super.initState();
    currentColor = Colors.purple;
  }

  void changeColor() {
    var random = Random();
    setState(() {
      currentColor = colors[random.nextInt(colors.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  myAppBar() {
    return AppBar(
      title: const Text('Ứng dụng đổi màu'),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  myBody() {
    return Container(
      color: currentColor,
      child: Column(
        children: [
          Text(
            'Màu hiện tại:',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text("Tím", style: TextStyle(color: currentColor, fontSize: 30)),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: changeColor,
                label: Text("Doi Mau"),
              ),
              ElevatedButton.icon(onPressed: null, label: Text("reset")),
            ],
          ),
        ],
      ),
    );
  }
}
