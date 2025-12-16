import 'package:flutter/material.dart';

class TinhBMI extends StatefulWidget {
  const TinhBMI({super.key});

  @override
  State<TinhBMI> createState() => _TinhBMIState();
}

class _TinhBMIState extends State<TinhBMI> {
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController weightCtrl = TextEditingController();

  // lưu chỉ số BMI và phân loại
  double? bmi;
  String? phanloai;

  void calculateBMI() {
    double? height = double.tryParse(heightCtrl.text);
    double? weight = double.tryParse(weightCtrl.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        bmi = null;
        phanloai = "Dữ liệu không hợp lệ.";
      });
      return;
    }

    double result = weight / (height * height);
    setState(() {
      bmi = result;

      if (result < 18.5)
        phanloai = "Thiếu cân";
      else if (result < 25)
        phanloai = "Bình thường";
      else if (result < 30)
        phanloai = "Thừa cân";
      else if (result >= 30)
        phanloai = "Béo phì";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  myAppBar() {
    return AppBar(
      title: const Text("Tính chỉ số BMI"),
      backgroundColor: Colors.cyan,
      centerTitle: true,
    );
  }

  myBody() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Chiều cao (m)",
              border: OutlineInputBorder(),
            ),
            controller: heightCtrl,
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Cân nặng (kg)",
              border: OutlineInputBorder(),
            ),
            controller: weightCtrl,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: calculateBMI,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            child: const Text(
              "Tính BMI",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          if (bmi != null)
            Text(
              "Chỉ số BMI: ${bmi!.toStringAsFixed(2)}\nPhân loại: $phanloai",
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }
}
