import 'package:dangnhap_api/service/auth_service.dart';
import 'package:dangnhap_api/ui_profile.dart';
import 'package:flutter/material.dart';

class FormDangNhap extends StatefulWidget {
  const FormDangNhap({super.key});

  @override
  State<FormDangNhap> createState() => _FormDangNhapState();
}

class _FormDangNhapState extends State<FormDangNhap> {
  // chìa khóa để điều khiển form
  //Kiểm tra form hợp lệ
  final _formKey = GlobalKey<FormState>();
  //lấy tài khoản, mật khẩu
  final _username = TextEditingController();
  final _password = TextEditingController();
  // Ẩn dấu sao cho password
  bool _obscure = true;

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final username = _username.text.trim();
    final password = _password.text.trim();

    bool success = await authService.login(username, password);
    if (!mounted) return;
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UIProfile()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sai username hoặc password!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  // APP BAR
  PreferredSizeWidget myAppBar() {
    return AppBar(title: Text("Trang Đăng Nhập"), centerTitle: true);
  }

  // BODY Trang Đăng Nhập
  Widget myBody() {
    return Padding(
      padding: const EdgeInsets.all(90),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Tên đăng nhập
            TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: "Tên Đăng Nhập",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v!.isEmpty ? "Vui lòng nhập tên đăng nhập" : null,
            ),

            const SizedBox(height: 10),

            //Mật khẩu
            TextFormField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (v) => v!.isEmpty ? "Vui lòng nhập mật khẩu" : null,
            ),

            const SizedBox(height: 10),
            //Nút Submit
            ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: Text("Đăng Nhập", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
