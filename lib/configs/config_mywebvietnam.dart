import 'package:flutter_back_end/models/request_dio.dart';

class ConfigsMywebvietnam {
  static final String signInApi =
      'https://api.mywebvietnam.net/va-json/v1/accounts/signin';
  static final String getProductsApi =
      'https://api.mywebvietnam.net/va-json/v1/products';
  static final String getProductsBRANDS =
      'https://api.mywebvietnam.net/va-json/v1/products/brands';
  static final String getCategoriesApi =
      'https://api.mywebvietnam.net/va-json/v1/products/categories';
  static final String getGroupProductApi =
      'https://api.mywebvietnam.net/va-json/v1/products/groups';
  static final String getOders = 'https://api.mywebvietnam.net/va-json/v1/orders';
  static final String getCustomers =
      'https://api.mywebvietnam.net/va-json/v1/customers';
  static final String getCustomersSubscribe =
      'https://api.mywebvietnam.net/va-json/v1/customers/subscribe';
  static final String getListPage = 'https://api.mywebvietnam.net/va-json/v1/pages';
  static final String getBlogsCategories =
      'https://api.mywebvietnam.net/va-json/v1/blogs/categories';
  static final String getBlogs = 'https://api.mywebvietnam.net/va-json/v1/blogs';
  static final String getThemes = 'https://api.mywebvietnam.net/va-json/v1/themes';
  static final String getAddressProvince =
      'https://api.mywebvietnam.net/va-json/v1/address/province';
  static final String getAddressDistrict =
      'https://api.mywebvietnam.net/va-json/v1/address/district/';
  static final String getAddressWard =
      'https://api.mywebvietnam.net/va-json/v1/address/ward/';
  static final String getRepostRevenue =
      'https://api.mywebvietnam.net/va-json/v1//reports/revenue';

  static final String title =
      'Để chỉnh sửa nhiều thông tin hơn , quý khách vui lòng truy cập vào trang quản trị bằng máy tính';
  static final String urlAvatarDefalut =
      'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg';

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

  static String getDashboard =
      'https://api.mywebvietnam.net/va-json/v1/reports/dashboard';
}
