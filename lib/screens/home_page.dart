import 'package:flutter/material.dart';
import 'package:flutter_back_end/screens/main_page.dart';
import 'package:flutter_back_end/screens/oders_page.dart';
import 'package:flutter_back_end/screens/products_page.dart';
import 'package:flutter_back_end/screens/settings_page.dart';
import 'package:get/get.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> listpage = [
    MainPage(),
    OrdersPage(),
    ProductsPage(),
    SettingsPage()
  ];
  ControllerMainPage controllerMainPage = Get.put(ControllerMainPage());

  @override
  void initState() {
    super.initState();
  }

  buildNew() {
    return Obx(() => Container(
          alignment: Alignment.center,
          height: controllerMainPage.newOder.value != 0 ? 15 : 0,
          width: controllerMainPage.newOder.value != 0 ? 15 : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: controllerMainPage.newOder.value != 0
              ? Text(
                  controllerMainPage.newOder.value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )
              : Container(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listpage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
          BottomNavigationBarItem(
              icon: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [Icon(Icons.assignment_rounded), buildNew()]),
              label: 'Đơn Hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox), label: 'Sản Phẩm'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài Đặt'),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff2c72b8),
        onTap: _onTapBottomNav,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onTapBottomNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
