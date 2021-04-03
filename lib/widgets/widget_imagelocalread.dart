import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/configs/config_theme.dart';
import 'package:flutter_back_end/controllers/controller_imagereading.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WidgetReadimage extends StatefulWidget {
  @override
  _WidgetReadimageState createState() => _WidgetReadimageState();
}

class _WidgetReadimageState extends State<WidgetReadimage> {
  ControllerReadImage _controllerReadImage = Get.put(ControllerReadImage());

  postImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      List<String> arr = File(image.path).uri.toString().split('/');
      dynamic fileName = arr[arr.length - 1];
      dynamic filepath = image.path.toString();
      //File(image.path).uri.toString().replaceAll(fileName, '');
      var respon = await Product.getimageFromPath(
        filepath,
        fileName,
        url: ConfigsMywebvietnam.imageLibrary,
        params: {'token': ControllerMainPage.webToken},
      );
      print(respon);
    } else {
      print('No image selected.');
    }
  }

  getLibraty() async {
    _controllerReadImage.maxLenght = _controllerReadImage.imageLink.length;
    var url = ConfigsMywebvietnam.imageLibrary;
    var response = await RequestDio.get(url: url, parames: {
      'token': ControllerMainPage.webToken,
      'limit': _controllerReadImage.limit,
      'offset': _controllerReadImage.offset
    });
    var data = response['data'];
    for (int i = 0; i < data.length; i++) {
      if (!_controllerReadImage.imageLink.contains(data[i]['file_link'])) {
        _controllerReadImage.imageLink.add(data[i]['file_link']);
        bool ischosen = false;
        if (_controllerReadImage.imageChosenLink.contains(data[i]['file_link']))
          ischosen = true;
        _controllerReadImage.imageisChose.add(ischosen);
      }
    }
    if (_controllerReadImage.maxLenght == _controllerReadImage.imageLink.length)
      _controllerReadImage.isFull = true;
    else
      _controllerReadImage.isFull = false;
  }

  clearImage() {
    _controllerReadImage.isFull = false;
    _controllerReadImage.imageLink.clear();
    _controllerReadImage.imageisChose.clear();
    _controllerReadImage.offset = 0;
  }

  loadmore() async {
    _controllerReadImage.isLoad.value = true;
    if (_controllerReadImage.isFull) _controllerReadImage.isLoad.value = false;
    print(_controllerReadImage.isLoad.value);
    _controllerReadImage.offset += 9;
    await getLibraty();
    await Future.delayed(Duration(seconds: 1));
    _controllerReadImage.isLoad.value = false;
  }

  dialogImageLibrary() {
    showModalBottomSheet(
        context: currentContext,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: ConfigTheme.backgroundColor,
        builder: (conotext) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: ConfigTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                height: currentContext.height * 0.06,
                child: Text(
                  'Thư viện ảnh',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Obx(() => NotificationListener<ScrollNotification>(
                    onNotification: (ctlScroll) {
                      if (ctlScroll is ScrollEndNotification) if (ctlScroll
                              .metrics.pixels ==
                          ctlScroll.metrics.maxScrollExtent) {
                        loadmore();
                        return true;
                      }
                      return false;
                    },
                    child: Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 3),
                        itemCount: _controllerReadImage.imageLink.length,
                        itemBuilder: buildItemLibrary,
                      ),
                    ),
                  )),
              loadingArea(),
              Container(
                color: Colors.grey.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonCustom.buttonWithIcon(Colors.teal[400],
                        Icons.vertical_align_top, 'Tải ảnh lên', () async {
                      await postImage();
                      clearImage();
                      getLibraty();
                    }),
                    ButtonCustom.buttonWithIcon(Colors.blueAccent[400],
                        Icons.check, 'Lấy tất cả ảnh đã chọn ', () {
                      Navigator.pop(currentContext);
                    })
                  ],
                ),
                height: currentContext.height * 0.05,
              )
            ],
          );
        });
  }

  Widget loadingArea() {
    return Obx(() => Container(
        width: double.infinity,
        color: Colors.grey.withOpacity(0.4),
        child: _controllerReadImage.isLoad.value
            ? CupertinoActivityIndicator()
            : (_controllerReadImage.isFull
                ? Text('đã tải hết ảnh')
                : Container())));
  }

  Widget buildItemLibrary(context, int index) {
    return InkWell(
        onTap: () {
          //Thêm ảnh
          _controllerReadImage.imageisChose[index] =
              !_controllerReadImage.imageisChose[index];

          if (_controllerReadImage.imageisChose[index]) {
            if (!_controllerReadImage.imageChosenLink
                .contains(_controllerReadImage.imageLink[index].trim())) {
              _controllerReadImage.imageChosenLink
                  .add(_controllerReadImage.imageLink[index]);
            }
          } else
            _controllerReadImage.imageChosenLink
                .remove(_controllerReadImage.imageLink[index]);
        },
        child: Obx(
          () => Stack(
            children: [
              Image.network(
                _controllerReadImage.imageLink[index],
                fit: BoxFit.cover,
                height: currentContext.height * 0.3 / 2,
              ),
              _controllerReadImage.imageisChose[index]
                  ? Icon(
                      Icons.check_circle_rounded,
                      size: 40,
                      color: Colors.blue[400],
                    )
                  : Container()
            ],
          ),
        ));
  }

  Widget buildItemChose(BuildContext context, int index) {
    return Stack(
      children: [
        Container(
          child: Image.network(
            _controllerReadImage.imageChosenLink[index],
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            child: IconButton(
              color: Colors.blue,
              icon: Icon(Icons.cancel),
              onPressed: () {
                _controllerReadImage.imageChosenLink
                    .remove(_controllerReadImage.imageChosenLink[index]);
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(4)),
              child: Text('Chọn ảnh', style: TextStyle(color: Colors.white))),
          onPressed: () {
            clearImage();
            getLibraty();
            dialogImageLibrary();
          },
        ),
        Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(5)),
            height: currentContext.height * 0.3,
            child: Obx(() => GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemCount: _controllerReadImage.imageChosenLink.length,
                  itemBuilder: buildItemChose,
                ))),
      ],
    );
  }
}
