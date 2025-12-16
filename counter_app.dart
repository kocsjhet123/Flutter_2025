import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: const Text('Ứng dụng đếm số'),
      backgroundColor: Colors.teal,
      centerTitle: true,
    );
  }

  Widget myBody() {
    return Container(
      color: Colors.teal.shade100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Giá trị hiện tại:',
            style: TextStyle(fontSize: 22, color: Colors.teal.shade900),
          ),
          const SizedBox(height: 10),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: decrement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Icon(Icons.remove, color: Colors.white),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: increment,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
