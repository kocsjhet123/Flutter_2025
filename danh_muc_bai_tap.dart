import 'package:change_color_app/change_app_color.dart';
import 'package:counter_app/counter_app.dart';
import 'package:cr_list/ds_cr.dart';
import 'package:dang_ky_form/dang_ky.dart';
import 'package:dang_nhap_form/dang_nhap.dart';
import 'package:dangnhap_api/form_dang_nhap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/my_product.dart';
import 'package:flutter_application_1/newspage.dart';
import 'package:form_gui_phan_hoi/gui_phan_hoi.dart';
import 'package:saved_place/saved_place.dart';
import 'package:tinh_bmi/tinhBMI.dart';
import 'package:tuhoc/home_page.dart';
import 'package:my_place/my_place.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Hàm xử lý việc chuyển Route (Điều hướng chính)
  void _navigateToPage(BuildContext context, Widget page) {
    // 1. Đóng Drawer
    Navigator.of(context).pop();
    // 2. Đẩy Route mới (trang mới) lên Stack của Navigator
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  // Widget tiện ích để tạo nhanh các mục menu
  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title),
      onTap: () => _navigateToPage(context, page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Mục Bài Tập Của Tôi'),
        backgroundColor: Colors.blueAccent,
      ),

      // --- START: Định nghĩa Widget Drawer ---
      drawer: Drawer(
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menu Bài Tập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // --- CÁC MỤC ĐIỀU HƯỚNG TỚI DỰ ÁN CON ---
            _buildTile(
              context,
              Icons.waving_hand,
              '1. Hello World (tuhoc)',
              const HomePage(),
            ),
            _buildTile(
              context,
              Icons.location_city,
              '2. My Place App',
              const MyPlace(),
            ),
            _buildTile(
              context,
              Icons.list,
              '3. CR List',
              const ListClassroom(),
            ),
            _buildTile(
              context,
              Icons.bookmark,
              '4. Saved Place',
              const SavedPlace(),
            ),
            _buildTile(
              context,
              Icons.color_lens,
              '5. Change Color App',
              const ChangeAppColor(),
            ),
            _buildTile(
              context,
              Icons.add,
              '6. Counter App',
              const CounterApp(),
            ),
            _buildTile(
              context,
              Icons.monitor_weight,
              '7. Tính BMI',
              const TinhBMI(),
            ),

            const Divider(),

            _buildTile(
              context,
              Icons.login,
              '8. Đăng Nhập Form',
              const DangNhap(),
            ),
            _buildTile(
              context,
              Icons.person_add,
              '9. Đăng Ký Form',
              const DangKyPage(),
            ),
            _buildTile(
              context,
              Icons.feedback,
              '10. Form Phản Hồi',
              const GuiPhanHoi(),
            ),

            const Divider(),

            _buildTile(
              context,
              Icons.api,
              '11. Flutter API',
              const ProductApi(),
            ),
            _buildTile(
              context,
              Icons.article,
              '12. NEW API',
              const MyNewsPage(),
            ),
            _buildTile(
              context,
              Icons.account_circle,
              '13. Đăng Nhập API',
              const FormDangNhap(),
            ),
          ],
        ),
      ),
    );
  }
}
