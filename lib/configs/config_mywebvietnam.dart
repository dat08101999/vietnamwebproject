import 'package:flutter_back_end/models/request_dio.dart';

class ConfigsMywebvietnam {
  static String signInApi =
      'https://api.mywebvietnam.net/va-json/v1/accounts/signin';
  static String getProductsApi =
      'https://api.mywebvietnam.net/va-json/v1/products';
  static String getProductsBRANDS =
      'https://api.mywebvietnam.net/va-json/v1/products/brands';
  static String getCategoriesApi =
      'https://api.mywebvietnam.net/va-json/v1/products/categories';
  static String getGroupProductApi =
      'https://api.mywebvietnam.net/va-json/v1/products/groups';
  static String getOders = 'https://api.mywebvietnam.net/va-json/v1/orders';
  static String getCustomers =
      'https://api.mywebvietnam.net/va-json/v1/customers';
  static String getCustomersSubscribe =
      'https://api.mywebvietnam.net/va-json/v1/customers/subscribe';
  static String getListPage = 'https://api.mywebvietnam.net/va-json/v1/pages';
  static String getBlogsCategories =
      'https://api.mywebvietnam.net/va-json/v1/blogs/categories';
  static String getBlogs = 'https://api.mywebvietnam.net/va-json/v1/blogs';
  static String getThemes = 'https://api.mywebvietnam.net/va-json/v1/themes';
  static String getAddressProvince =
      'https://api.mywebvietnam.net/va-json/v1/address/province';
  static String getAddressDistrict =
      'https://api.mywebvietnam.net/va-json/v1/address/district/';
  static String getAddressWard =
      'https://api.mywebvietnam.net/va-json/v1/address/ward/';
  static String getRepostRevenue =
      'https://api.mywebvietnam.net/va-json/v1//reports/revenue';

  static String title =
      'Để chỉnh sửa nhiều thông tin hơn , quý khách vui lòng truy cập vào trang quản trị bằng máy tính';

  static Future<String> getAddress(Map<String, dynamic> mapAddress) async {
    String urlDistrict = '$getAddressDistrict${mapAddress['province']}';
    String urlWard = '$getAddressWard${mapAddress['district']}';
    String _province, _district, _ward;

    var paramas = {'token': '4779ce0e8eeb2de09fd04dd38c7d0526'};
    var responseProvince =
        await RequestDio.get(url: getAddressProvince, parames: paramas);
    var responseDistrict =
        await RequestDio.get(url: urlDistrict, parames: paramas);
    var responseWard = await RequestDio.get(url: urlWard, parames: paramas);

    if (responseProvince['success'] &&
        responseDistrict['success'] &&
        responseWard['success']) {
      List provinces = responseProvince['data'];
      provinces.forEach((element) {
        if (element['id'] == mapAddress['province']) {
          _province = element['name'];
        }
      });
      List districts = responseDistrict['data'];
      districts.forEach((element) {
        if (element['id'] == mapAddress['district']) {
          _district = element['name'];
        }
      });
      List wards = responseWard['data'];
      wards.forEach((element) {
        if (element['id'] == mapAddress['ward']) {
          _ward = element['name'];
        }
      });
      return '${mapAddress['detail']} ,$_ward ,$_district ,$_province';
    } else {
      print('lỗi getAddress');
      return null;
    }
  }
}
