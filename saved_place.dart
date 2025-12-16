import 'package:flutter/material.dart';

class SavedPlace extends StatelessWidget {
  const SavedPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Place")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconTop(),
              SizedBox(height: 40),
              welcomText(),
              SizedBox(height: 40),
              searchBox(),
              SizedBox(height: 60),
              Text("Saved Places"),
              SizedBox(height: 20),
              gridImage(),
            ],
          ),
        ),
      ),
    );
  }

  // Icon top right
  Widget iconTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: Icon(Icons.extension)),
      ],
    );
  }

  Widget welcomText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 60),
        children: [
          TextSpan(
            text: "Welcom,",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: "Charlie"),
        ],
      ),
    );
  }

  Widget searchBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget gridImage() {
    List<String> imgList = [
      "assets/anh1.jpg",
      "assets/anh2.jpg",
      "assets/anh3.jpg",
      "assets/anh4.jpg",
    ];
    // List<Map<String, dynamic>> imgList =[
    //   {
    //     "img" : "assets/anh1.jpg"
    //   },
    //   {
    //     "img" : "assets/anh2.jpg"
    //   },
    //   {
    //     "img" : "assets/anh3.jpg"
    //   },
    //   {
    //     "img" : "assets/anh4.jpg"
    //   }
    // ];
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        //children: imgList.map((item){
        children: List.generate(imgList.length, (index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                //image: AssetImage(item["img"]),
                image: AssetImage(imgList[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
