import 'package:flutter/material.dart';
import 'package:flutter_back_end/screens/blogs_and_chart_page.dart';
import 'package:flutter_back_end/screens/oders_page.dart';
import 'package:flutter_back_end/screens/products_page.dart';
import 'package:flutter_back_end/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({this.name});

  final String name;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> listpage = [
    BlogsAndChart(),
    OrdersPage(),
    ProductsPage(),
    SettingsPage()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: listpage.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[200],
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded), label: 'Đơn Hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: 'Sản Phẩm'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài Đặt'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onTapBottomNav,
      ),
    );
  }

  void _onTapBottomNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
