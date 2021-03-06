import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:get/get.dart';

class ControllerAddressprovince extends GetxController {
  String provinceValue;
  List<DropdownMenuItem<String>> provinceItems = [];
  var province;

  getProvince() async {
    var paramas = {'token': ControllerMainPage.webToken};
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getAddressProvince, parames: paramas);
    return response;
  }

  getAllData() async {
    province = await getProvince();
    if (province['success'].toString().trim() == 'true')
      for (int i = 0; i < province['data'].length; i++) {
        provinceItems.add(DropdownMenuItem<String>(
          child: Container(
            child: Text(province['data'][i]['name']),
            width: MediaQuery.of(currentContext).size.width * 0.7,
          ),
          value: province['data'][i]['id'],
        ));
      }
    update();
  }

  changeData(value) {
    provinceValue = value;
    update();
    Get.find<ControllerAddressdistrict>().getAllData(value);
  }
}

class ControllerAddressdistrict extends GetxController {
  String districtValue;
  List<DropdownMenuItem<String>> districtItems = [];
  var district;
  getDistrict(provinceId) async {
    var paramas = {'token': ControllerMainPage.webToken};
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getAddressDistrict + '/' + provinceId,
        parames: paramas);
    return response;
  }

  getAllData(provinceId) async {
    districtItems.clear();
    district = await getDistrict(provinceId);
    if (district['success'] == true) {
      for (int i = 0; i < district['data'].length; i++) {
        districtItems.add(DropdownMenuItem<String>(
          child: Container(
            child: Text(district['data'][i]['name']),
            width: MediaQuery.of(currentContext).size.width * 0.7,
          ),
          value: district['data'][i]['id'],
        ));
      }
      districtValue = district['data'][0]['id'];
      await Get.find<ControllerWard>().getAlldata(districtValue);
    }
    update();
  }

  changeData(value) {
    districtValue = value;
    update();
    Get.find<ControllerWard>().getAlldata(value);
  }
}

class ControllerWard extends GetxController {
  String wardValue;
  List<DropdownMenuItem<String>> wardItems = [];
  var ward;
  getWard(districtId) async {
    var paramas = {'token': ControllerMainPage.webToken};
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getAddressWard + '/' + districtId,
        parames: paramas);
    return response;
  }

  getAlldata(districtId) async {
    wardItems.clear();
    ward = await getWard(districtId);
    if (ward['success'] == true) {
      for (int i = 0; i < ward['data'].length; i++) {
        wardItems.add(DropdownMenuItem<String>(
          child: Container(
            child: Text(ward['data'][i]['name']),
            width: MediaQuery.of(currentContext).size.width * 0.7,
          ),
          value: ward['data'][i]['id'],
        ));
      }
      wardValue = ward['data'][0]['id'];
    }
    update();
  }

  changeData(value) {
    wardValue = value;
    update();
  }
}
