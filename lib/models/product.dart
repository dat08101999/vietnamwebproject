import 'dart:convert';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/product_controller.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/models/show_toast.dart';

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
    try {
      var response = await RequestDio.post(
        url: ConfigsMywebvietnam.getProductsApi + '/' + product.id.toString(),
        params: {'token': ControllerMainPage.webToken},
        data: data,
      );
      Loading.dismiss();
      if (response['success'] == true) {
        ShowToast.show(title: 'Cập Nhập Thành Công');
        return true;
      } else {
        ShowToast.show(title: response['message']);
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
}
