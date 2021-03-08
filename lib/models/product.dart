import 'dart:convert';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class Product {
  int id;
  String thumbnail;
  List<String> pictures;
  String name;
  String sku;
  List<Map<String, dynamic>> categories;
  List<Map<String, dynamic>> groups;
  dynamic brand;
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
    this.sku,
    this.categories,
    this.groups,
    this.brand,
    this.priceSale,
    this.priceRegular,
    this.stock,
    this.variations,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'pictures': pictures,
      'name': name,
      'sku': sku,
      'categories': categories,
      'groups': groups,
      'brand': brand,
      'price_sale': priceSale,
      'price_regular': priceRegular,
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
      sku: map['sku'],
      categories:
          List<Map<String, dynamic>>.from(map['categories']?.map((x) => x)),
      groups: List<Map<String, dynamic>>.from(map['groups']?.map((x) => x)),
      brand: map['brand'],
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
    return 'Product(id: $id, thumbnail: $thumbnail, pictures: $pictures, name: $name, sku: $sku, categories: $categories, groups: $groups, brand: $brand, priceSale: $priceSale, priceRegular: $priceRegular, stock: $stock, variations: $variations, link: $link)';
  }


  // static upDateCustomer(Product product) async {
    // try {
  //     var response = await RequestDio.httpPost(
  //         url: ConfigsMywebvietnam.getCustomers +
  //             '/' +
  //             customer.id.toString() +
  //             '?token=' +
  //             ControllerMainPage.webToken,
  //         body: {
  //           'name': customer.name,
  //           'phone': customer.phone,
  //           'address': customer.address,
  //           'email': customer.email,
  //           'province': customer.province.toString(),
  //           'district': customer.district.toString(),
  //           'ward': customer.ward.toString(),
  //         },
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //           'Cookie':
  //               'dbdad159c321a98161b40cc2ec4ba243=81c797dc5b7aecb557f090be5dd37a4254653cac'
  //         });
  //     response = json.decode(response);
  //     if (response['success'] == true)
  //       return true;
  //     else {
  //       requestError = response['message'];
  //       return false;
  //     }
  //   } catch (ex, trace) {
  //     print(ex + trace);
  //     requestError = 'Xảy ra lỗi';
  //     return false;
  //   }
  // }
}
