import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class ConfigsMywebvietnam {
  static final String apiSever = 'https://api.mywebvietnam.net/va-json/v1';
  static final String signInApi = apiSever + '/accounts/signin';
  static final String getProductsApi = apiSever + '/products';
  static final String getProductsBRANDS = apiSever + '/products/brands';
  static final String getCategoriesApi = apiSever + '/products/categories';
  static final String getGroupProductApi = apiSever + '/products/groups';
  static final String getOrders = apiSever + '/orders';
  static final String getCustomers = apiSever + '/customers';
  static final String getCustomersSubscribe = apiSever + '/customers/subscribe';
  static final String getListPage = apiSever + '/pages';
  static final String getBlogsCategories = apiSever + '/blogs/categories';
  static final String getBlogs = apiSever + '/blogs';
  static final String getThemes = apiSever + '/themes';
  static final String getAddressProvince = apiSever + '/address/province';
  static final String getAddressDistrict = apiSever + '/address/district/';
  static final String getAddressWard = apiSever + '/address/ward/';
  static final String getRepostRevenue = apiSever + '/reports/revenue';
  static final String imageLibrary = apiSever + '/libraries';
  static final String variationApi = apiSever + '/products/variations';
  static final String getDashboard = apiSever + '/reports/dashboard';
  static final String getInfoCustomer = apiSever + '/customers';
  static final String confirmOrder = getOrders + '/confirm';
  static final String cancelOrder = getOrders + '/cancel';
  static final String sendedOrder = getOrders + '/sended';
  static final String successOrder = getOrders + '/success';
  static final String purchaseOrder = getOrders + '/purchase';

  static final String title =
      'Để chỉnh sửa nhiều thông tin hơn , quý khách vui lòng truy cập vào trang quản trị bằng máy tính';
  static final String urlAvatarDefalut =
      'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg';
  static final String urlNoImage =
      'https://thumbs.dreamstime.com/b/no-image-available-icon-vector-illustration-flat-design-140476186.jpg';

  static Future<String> getAddress(Map<String, dynamic> mapAddress) async {
    String urlDistrict = '$getAddressDistrict${mapAddress['province']}';
    String urlWard = '$getAddressWard${mapAddress['district']}';
    String _province = '', _district = '', _ward = '';
    var paramas = {'token': ControllerMainPage.webToken};
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
        if (element['id'].toString().trim() ==
            mapAddress['province'].toString().trim()) {
          _province = element['name'];
        }
      });
      List districts = responseDistrict['data'];
      districts.forEach((element) {
        if (element['id'].toString().trim() ==
            mapAddress['district'].toString().trim()) {
          _district = element['name'];
        }
      });
      List wards = responseWard['data'];
      wards.forEach((element) {
        if (element['id'].toString().trim() ==
            mapAddress['ward'].toString().trim()) {
          _ward = element['name'];
        }
      });
      return '$_ward ,$_district ,$_province';
    } else {
      print('lỗi getAddress');
      return null;
    }
  }
}
