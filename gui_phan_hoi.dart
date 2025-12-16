import 'package:flutter/material.dart';

class GuiPhanHoi extends StatefulWidget {
  const GuiPhanHoi({super.key});

  @override
  State<GuiPhanHoi> createState() => _GuiPhanHoiState();
}

class _GuiPhanHoiState extends State<GuiPhanHoi> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController commentCtrl = TextEditingController();

  int sao = 1; // mặc định sao là 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  myAppBar() {
    return AppBar(
      title: Text("Gửi phản hồi"),
      backgroundColor: Colors.orange,
      centerTitle: true,
    );
  }

  myBody() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // họ tên
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: "Họ tên",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          // đánh giá sao
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: "Đánh giá(1-5 sao)",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.star),
            ),
            items: List.generate(
              5,
              (i) =>
                  DropdownMenuItem(value: i + 1, child: Text("${i + 1} sao")),
            ),
            onChanged: (value) {
              setState(() {
                sao = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          // nội dung gop ý
          TextField(
            controller: commentCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Nội dung gop ý",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.feedback),
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: 25),

          // Nút gửi phản hồi
          Center(
            child: ElevatedButton(
              onPressed: () {
                // bạn có thể xử lý dữ liệu gửi ở đây
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đã gửi phản hồi!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.send, color: Colors.white), // icon gửi
                  SizedBox(width: 8),
                  Text(
                    "Gửi phản hồi",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
