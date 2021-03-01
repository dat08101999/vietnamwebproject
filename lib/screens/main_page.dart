import 'package:flutter/material.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/models_signinInfo.dart';
import 'package:flutter_back_end/widgets/widget_chart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _dropdownValue = 0;
  BoxDecoration decorationBody() {
    return BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)));
  }

  Widget buildBodyHeadArea() {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.stack.imgur.com/5swJm.png'),
          ),
          title: Text('Demo'),
          subtitle: Text('Basic'),
          trailing: DropdownButton(
            value: _dropdownValue,
            onChanged: (value) {
              _dropdownValue = value;
              setState(() {});
            },
            icon: Icon(Icons.arrow_drop_down_rounded),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text(''),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridViewItem(String title, String count) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child: Center(
              child: Text(count,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Bold',
                      fontWeight: FontWeight.bold)),
            )),
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
        height: MediaQuery.of(currentContext).size.height * 0.3,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1.5),
          children: [
            buildGridViewItem('Đơn Hàng', '11'),
            buildGridViewItem('Khách Hàng', '12'),
            buildGridViewItem('Sản Phẩm', '12'),
            buildGridViewItem('Title Lable', '12'),
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
  }

  @override
  Widget build(BuildContext context) {
    print(SignInInfo.moneyFomat('3000'));
    return Stack(
      children: [
        Container(
            color: Colors.blue,
            height: MediaQuery.of(currentContext).size.height,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(currentContext).size.height * 0.02),
              child: Align(
                child: Text(
                  'xin chào,',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.topCenter,
              ),
            )),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(currentContext).size.height * 0.05),
          child: buildBodyArea(),
        )
      ],
    );
  }
}
