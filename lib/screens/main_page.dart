import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/configs/config_user.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/screens/customers_page.dart';
import 'package:flutter_back_end/widgets/widget_chart.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isShowmenu = false;
  ControllerMainPage controllerMainPage = Get.put(ControllerMainPage());
  String selecteditem = '';
  double width = MediaQuery.of(currentContext).size.width;
  double heigth = MediaQuery.of(currentContext).size.height;
  BoxDecoration decorationBody() {
    return BoxDecoration(
        color: Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)));
  }

  Widget buildBodyHeadArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(ConfigsMywebvietnam.urlAvatarDefalut),
            ),
            title: Text(controllerMainPage.name),
            subtitle: Text('Basic ' + controllerMainPage.basic),
            trailing: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                dropdown();
              },
            )),
      ),
    );
  }

  dropdown() {
    List<InkWell> list = List<InkWell>();
    try {
      for (int i = 0; i < controllerMainPage.info.length; i++) {
        list.add(InkWell(
            onTap: () {
              controllerMainPage.changeData(i);
              Navigator.pop(currentContext);
            },
            child: ListTile(
              leading: Icon(Icons.blur_circular_sharp),
              title: Text(
                controllerMainPage.info[i]['name'],
                style: TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )));
      }
    } catch (ex, trace) {
      print(trace);
      return list;
    }
    print(list);
    popUpChosing(list)..show();
  }

  popUpChosing(list) {
    return YYDialog().build(context)
      ..width = MediaQuery.of(context).size.width * 0.7
      ..gravity = Gravity.rightTop
      ..margin = EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
          right: MediaQuery.of(context).size.width * 0.05)
      ..borderRadius = 10
      ..widget(
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView(
            children: list,
          ),
        ),
      );
  }

  Widget buildGridViewItem(String title, String count, {bool isIncrease}) {
    return Container(
      width: width * 0.5,
      height: heigth * 0.3 * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(count,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Bold',
                      fontWeight: FontWeight.bold)),
              isIncrease != null
                  ? (isIncrease
                      ? Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                        ))
                  : Container()
            ])),
            WidgetSpan(
                child: Center(
              child: Text(title,
                  style: TextStyle(fontSize: 15, fontFamily: 'Bold')),
            )),
          ]),
        ),
      ),
    );
  }

  Widget buildBodyCenterArea() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        height: heigth * 0.3,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
              child: buildGridViewItem(
                  'Đơn Hàng', controllerMainPage.oders.toString(),
                  isIncrease: controllerMainPage.oderIncrease),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.5 + 4),
              child: InkWell(
                onTap: () {
                  Get.to(CustomersPage());
                },
                child: buildGridViewItem(
                    'Khách Hàng', controllerMainPage.customers.toString(),
                    isIncrease: controllerMainPage.customerIncease),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: heigth * 0.3 * 0.5 + 4),
              child: buildGridViewItem(
                  'Sản Phẩm', controllerMainPage.products.toString()),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: heigth * 0.3 * 0.5 + 4, left: width * 0.5 + 4),
              child: buildGridViewItem(
                  'Thu nhập', controllerMainPage.money.toString(),
                  isIncrease: controllerMainPage.moneyIncrase),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChartArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height: MediaQuery.of(context).size.height * 0.5,
        child: WidgetChart(),
      ),
    );
  }

  Widget buildBodyArea() {
    return GetBuilder<ControllerMainPage>(builder: (builder) {
      return Container(
        height: MediaQuery.of(currentContext).size.height * 0.85,
        decoration: decorationBody(),
        child: ListView(
          children: [
            buildBodyHeadArea(),
            buildBodyCenterArea(),
            buildChartArea()
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    controllerMainPage.getInforMation();
    return Stack(
      children: [
        Container(
            color: Colors.blue,
            height: MediaQuery.of(currentContext).size.height,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(currentContext).size.height * 0.02),
                child: Align(
                  child: Text(
                    'xin chào, ${ConfigUser.userProfile.name}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(currentContext).size.height * 0.1),
          child: buildBodyArea(),
        )
      ],
    );
  }
}
