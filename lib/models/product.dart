import 'dart:convert';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/product_controller.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_show_notifi.dart';
import 'package:dio/dio.dart' show MultipartFile;

class Product {
  int id;
  String thumbnail;
  List<String> pictures;
  String name;
  String description;
  String keyword;
  String content;
  String sku;
  List<Map<String, dynamic>> categories;
  List<Map<String, dynamic>> groups;
  dynamic brands;
  int priceSale;
  int priceRegular;
  int stock;
  List<Map<String, dynamic>> variations;
  String link;
  Product({
    this.id,
    this.thumbnail,
    this.pictures,
    this.name,
    this.description,
    this.keyword,
    this.content,
    this.sku,
    this.categories,
    this.groups,
    this.brands,
    this.priceSale,
    this.priceRegular,
    this.stock,
    this.variations,
    this.link,
  });

  static Future<Product> getProduct(String id) async {
    try {
      var params = {
        'token': ControllerMainPage.webToken,
      };
      var response = await RequestDio.get(
          url: ConfigsMywebvietnam.getProductsApi + '/' + id, parames: params);
      if (response['success'] == true) {
        return Product.fromMap(response['data'][0]);
      } else {
        return null;
      }
    } catch (e) {
      ShowNotifi.showToast(title: 'Thông tin đơn hàng bị trống');
      return null;
    }
  }

  static deleteProduct(Product product) async {
    try {
      var params = {
        'token': ControllerMainPage.webToken,
      };
      Loading.show();
      var response = await RequestDio.delete(
          url: '${ConfigsMywebvietnam.getProductsApi}/${product.id}',
          paramas: params);
      Loading.dismiss();
      if (response['success']) {
        ShowNotifi.showToast(title: 'Xóa Sản Phẩm Thành Công');
        return true;
      } else
        ShowNotifi.showToast(title: response['message']);
      return false;
    } catch (e, trace) {
      print(trace);
      return false;
    }
  }

  static updateProduct(
      Product product, ProductController productController) async {
    Loading.show();
    var data = {
      'name': product.name,
      'description': product.description ?? '',
      'keyword': product.keyword ?? product.name,
      'price_regular': product.priceRegular,
      'price_sale': product.priceSale,
      'brands': product.brands,
      'categories[0]': productController.idCategoriesSelected,
      'groups[]': product.groups,
      'thumbnail': product.thumbnail ?? ConfigsMywebvietnam.urlNoImage,
      'pictures': product.pictures,
      'stock': product.stock,
      'sku': product.sku ?? '',
      'variations': product.variations,
      'content': product.content ?? ''
    };
    print(product.id);
    print(data);
    try {
      var response = await RequestDio.post(
        url: ConfigsMywebvietnam.getProductsApi + '/' + product.id.toString(),
        params: {'token': ControllerMainPage.webToken},
        data: data,
      );
      Loading.dismiss();
      if (response['success'] == true) {
        ShowNotifi.showToast(title: 'Cập Nhập Thành Công');
        return true;
      } else {
        ShowNotifi.showToast(title: response['message']);
        return false;
      }
      // ignore: unused_catch_stack
    } catch (ex, trace) {
      print(ex);
      return false;
    }
  }

  Product copyWith({
    int id,
    String thumbnail,
    List<String> pictures,
    String name,
    String description,
    String keyword,
    String content,
    String sku,
    List<Map<String, dynamic>> categories,
    List<Map<String, dynamic>> groups,
    dynamic brands,
    int priceSale,
    int priceRegular,
    int stock,
    List<Map<String, dynamic>> variations,
    String link,
  }) {
    return Product(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      pictures: pictures ?? this.pictures,
      name: name ?? this.name,
      description: description ?? this.description,
      keyword: keyword ?? this.keyword,
      content: content ?? this.content,
      sku: sku ?? this.sku,
      categories: categories ?? this.categories,
      groups: groups ?? this.groups,
      brands: brands ?? this.brands,
      priceSale: priceSale ?? this.priceSale,
      priceRegular: priceRegular ?? this.priceRegular,
      stock: stock ?? this.stock,
      variations: variations ?? this.variations,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'pictures': pictures,
      'name': name,
      'description': description,
      'keyword': keyword,
      'content': content,
      'sku': sku,
      'categories': categories,
      'groups': groups,
      'brand': brands,
      'priceSale': priceSale,
      'priceRegular': priceRegular,
      'stock': stock,
      'variations': variations,
      'link': link,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['id'],
      thumbnail: map['thumbnail'],
      pictures: List<String>.from(map['pictures']),
      name: map['name'],
      description: map['description'],
      keyword: map['keyword'],
      content: map['content'],
      sku: map['sku'],
      categories:
          List<Map<String, dynamic>>.from(map['categories']?.map((x) => x)),
      groups: List<Map<String, dynamic>>.from(map['groups']?.map((x) => x)),
      brands: map['brand'],
      priceSale: map['price_sale'],
      priceRegular: map['price_regular'],
      stock: map['stock'],
      variations:
          List<Map<String, dynamic>>.from(map['variations']?.map((x) => x)),
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, thumbnail: $thumbnail, pictures: $pictures, name: $name, description: $description, keyword: $keyword, content: $content, sku: $sku, categories: $categories, groups: $groups, brands: $brands, priceSale: $priceSale, priceRegular: $priceRegular, stock: $stock, variations: $variations, link: $link)';
  }

  static getimageFromPath(path, filename, {url, params}) async {
    var response = await RequestDio.post(url: url, params: params, data: {
      'img_file[]': await MultipartFile.fromFile(path, filename: filename)
    });
    return response;
  }

  static updateVariation(
      id, Map<String, dynamic> data, List<String> picterList) async {
    Map<String, dynamic> tempData = data;
    for (int i = 0; i < picterList.length; i++) {
      tempData.addAll({'pictures[$i]': picterList[i]});
    }
    var response = await RequestDio.post(
        params: {'token': ControllerMainPage.webToken},
        url: ConfigsMywebvietnam.variationApi + '/' + id.toString(),
        data: tempData);
    return response;
  }

  static addVariation(
      Map<String, dynamic> data, List<String> picterList) async {
    Map<String, dynamic> tempData = data;
    for (int i = 0; i < picterList.length; i++) {
      tempData.addAll({'variations[0][pictures][$i]': picterList[i]});
    }
    var response = await RequestDio.post(
        params: {'token': ControllerMainPage.webToken},
        url: ConfigsMywebvietnam.variationApi,
        data: tempData);
    return response;
  }
}
