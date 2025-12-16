import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Place")),
      body: Column(children: [block1(), block2(), block3(), block4()]),
    );
  }

  Widget block1() {
    var src =
        "https://images.pexels.com/photos/33853817/pexels-photo-33853817.jpeg";
    return Image(image: NetworkImage(src));
  }

  Widget block2() {
    var title = "Oeschinen Lake Campground";
    var subtitle = "Kandersteg, Switzerland";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.red),
              Text("41"),
            ],
          ),
        ],
      ),
    );
  }

  Widget block3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(Icons.call, color: Colors.blue),
            Text("CALL", style: TextStyle(color: Colors.blue)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.near_me, color: Colors.blue),
            Text("ROUTE", style: TextStyle(color: Colors.blue)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.share, color: Colors.blue),
            Text("SHARE", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget block4() {
    var data =
        "Chiều 30/9, tại buổi tiếp xúc cử tri đơn vị bầu cử số 10 (Hà Nội), Tổng Bí thư Tô Lâm cho biết công tác chuẩn bị nhân sự cho đại hội Đảng các cấp và Đại hội lần thứ 14 đang được triển khai đúng tiến độ. Điểm nổi bật là chủ trương ";
    return Padding(padding: const EdgeInsets.all(20.0), child: Text(data));
  }
}
