import 'package:flutter/material.dart';

class DangKyPage extends StatefulWidget {
  const DangKyPage({super.key});

  @override
  State<DangKyPage> createState() => _DangKyPageState();
}

class _DangKyPageState extends State<DangKyPage> {
  // Controller
  final TextEditingController _hoTenController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matKhauController = TextEditingController();
  final TextEditingController _xacNhanMatKhauController =
      TextEditingController();

  // Ẩn/hiện mật khẩu
  bool _isMatKhauVisible = false;
  bool _isXacNhanMatKhauVisible = false;

  // 🆕 Thêm biến lỗi cho từng trường
  String? _hoTenError;
  String? _emailError;
  String? _matKhauError;
  String? _xacNhanMatKhauError;

  void _handleDangKy() {
    setState(() {
      // Reset lỗi cũ
      _hoTenError = null;
      _emailError = null;
      _matKhauError = null;
      _xacNhanMatKhauError = null;
    });

    final hoTen = _hoTenController.text.trim();
    final email = _emailController.text.trim();
    final matKhau = _matKhauController.text.trim();
    final xacNhanMatKhau = _xacNhanMatKhauController.text.trim();

    bool hasError = false;

    if (hoTen.isEmpty) {
      _hoTenError = 'Vui lòng nhập họ tên';
      hasError = true;
    }
    if (email.isEmpty) {
      _emailError = 'Vui lòng nhập email';
      hasError = true;
    } else if (!email.contains('@')) {
      _emailError = 'Email không hợp lệ';
      hasError = true;
    }
    if (matKhau.isEmpty) {
      _matKhauError = 'Vui lòng nhập mật khẩu';
      hasError = true;
    } else if (matKhau.length < 6) {
      _matKhauError = 'Mật khẩu phải có ít nhất 6 ký tự';
      hasError = true;
    }
    if (xacNhanMatKhau.isEmpty) {
      _xacNhanMatKhauError = 'Vui lòng xác nhận mật khẩu';
      hasError = true;
    } else if (xacNhanMatKhau != matKhau) {
      _xacNhanMatKhauError = 'Mật khẩu xác nhận không khớp';
      hasError = true;
    }

    // Nếu không có lỗi
    if (!hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thành công tài khoản: $email'),
          backgroundColor: Colors.green,
        ),
      );
    }

    // Cập nhật giao diện lỗi
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bài tập',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Form Đăng ký tài khoản',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Họ tên
                          TextField(
                            controller: _hoTenController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_outline),
                              labelText: 'Họ tên',
                              helperText: _hoTenError,
                              helperStyle: const TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Email
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              labelText: 'Email',
                              helperText: _emailError,
                              helperStyle: const TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Mật khẩu
                          TextField(
                            controller: _matKhauController,
                            obscureText: !_isMatKhauVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              labelText: 'Mật khẩu',
                              helperText: _matKhauError,
                              helperStyle: const TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isMatKhauVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isMatKhauVisible = !_isMatKhauVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Xác nhận mật khẩu
                          TextField(
                            controller: _xacNhanMatKhauController,
                            obscureText: !_isXacNhanMatKhauVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              labelText: 'Xác nhận mật khẩu',
                              helperText: _xacNhanMatKhauError,
                              helperStyle: const TextStyle(color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isXacNhanMatKhauVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isXacNhanMatKhauVisible =
                                        !_isXacNhanMatKhauVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _handleDangKy,
                              icon: const Icon(Icons.person_add),
                              label: const Text(
                                'Đăng ký',
                                style: TextStyle(fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
