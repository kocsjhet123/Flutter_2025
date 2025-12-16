import 'package:flutter/material.dart';

class ListClassroom extends StatelessWidget {
  const ListClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách lớp học")),
      body: SafeArea(child: myBody()),
    );
  }

  Widget myBody() {
    List<Map<String, dynamic>> cousesList = [
      {
        "title": "Lớp học Flutter",
        "code": "FL001",
        "students": 50,
        "image":
            "https://images.pexels.com/photos/30437321/pexels-photo-30437321.jpeg",
      },
      {
        "title": "Lớp học React",
        "code": "RE001",
        "students": 40,
        "image":
            "https://images.pexels.com/photos/33894780/pexels-photo-33894780.jpeg",
      },
      {
        "title": "Lớp học NodeJS",
        "code": "ND001",
        "students": 30,
        "image":
            "https://images.pexels.com/photos/31618288/pexels-photo-31618288.jpeg",
      },
    ];
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(cousesList.length, (index) //=> block()
      {
        var course = cousesList[index];
        return block(
          title: course["title"],
          code: course["code"],
          students: course["students"]!,
          urlImage: course["image"],
        );
      }),
    );
  }

  Widget block({
    required String title,
    required String code,
    required int students,
    required String urlImage,
  }) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ), // Khoảng cách bên ngoài
      padding: EdgeInsets.all(10), // Khoảng cách bên trong
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(urlImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "Mã lớp: $code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Text(
                "$students học viên",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              print("Menu");
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
