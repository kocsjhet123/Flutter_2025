import 'package:dangnhap_api/model/user_profile.dart';
import 'package:dangnhap_api/service/auth_service.dart';
import 'package:flutter/material.dart';

class UIProfile extends StatefulWidget {
  const UIProfile({super.key});

  @override
  State<UIProfile> createState() => _UIProfileState();
}

class _UIProfileState extends State<UIProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  // giao diện appbar
  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: Text("Profile", style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,

      /// Sau khi nhấn vào thanh icon Logout thì chuyển về form đăng nhập
      actions: [
        IconButton(
          onPressed: () async {
            await authService.logout();
            if (!mounted) return;
            Navigator.pop(context); // quay về màn hình login
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  // giao diện body
  Widget myBody() {
    return FutureBuilder<UserProfile?>(
      future: authService.getProfile(),
      builder: (context, snapshot) {
        // load dữ liệu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text("Không có thông tin người dùng"));
        }
        // có dữ liệu
        final user = snapshot.data!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.image),
              ),
              const SizedBox(height: 16),

              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              Text("Tuổi: ${user.age}"),
              Text("Giới tính: ${user.genderVN}"),
              Text("Email: ${user.email}"),
              Text("SĐT: ${user.phone}"),

              const SizedBox(height: 12),
              Chip(label: Text("Role: ${user.role}")),
            ],
          ),
        );
      },
    );
  }
}
