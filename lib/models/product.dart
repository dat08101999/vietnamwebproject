import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/request_dio.dart';

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

  static updateProduct(Product product) async {
    var data = {
      'name': product.name,
      'description': product.description ?? '',
      'keyword': product.keyword ?? '',
      'price_regular': product.priceRegular,
      'price_sale': product.priceSale,
      'brand': '161518345383718400',
      'categories': '157049836671845400',
      'groups': '157049894605637900',
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
      if (response['success'] == true)
        return true;
      else {
        print(response['message']);
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
      'brands': brands,
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
      brands: map['brands'],
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

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.id == id &&
        o.thumbnail == thumbnail &&
        listEquals(o.pictures, pictures) &&
        o.name == name &&
        o.description == description &&
        o.keyword == keyword &&
        o.content == content &&
        o.sku == sku &&
        listEquals(o.categories, categories) &&
        listEquals(o.groups, groups) &&
        o.brands == brands &&
        o.priceSale == priceSale &&
        o.priceRegular == priceRegular &&
        o.stock == stock &&
        listEquals(o.variations, variations) &&
        o.link == link;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        thumbnail.hashCode ^
        pictures.hashCode ^
        name.hashCode ^
        description.hashCode ^
        keyword.hashCode ^
        content.hashCode ^
        sku.hashCode ^
        categories.hashCode ^
        groups.hashCode ^
        brands.hashCode ^
        priceSale.hashCode ^
        priceRegular.hashCode ^
        stock.hashCode ^
        variations.hashCode ^
        link.hashCode;
  }
}
