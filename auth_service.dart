import 'package:dangnhap_api/model/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  ///Đăng Nhập
  Future<bool> login(String username, String password) async {
    try {
      final res = await _dio.post(
        "https://dummyjson.com/auth/login",
        data: {"username": username, "password": password},
        options: Options(
          contentType: "application/json",
          validateStatus: (_) => true,
        ),
      );

      /// kiểm tra đăng nhập thành công
      /// nếu thành công thì luu lại token
      if (res.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", res.data["accessToken"]);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  // Lấy thông tin user
  Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null) return null;

    try {
      final res = await _dio.get(
        "https://dummyjson.com/auth/me",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (res.statusCode == 200) {
        return UserProfile.formJson(res.data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Đăng xuất
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}

final authService = AuthService();
