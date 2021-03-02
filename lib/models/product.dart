import 'dart:convert';

class Product {
  int id;
  String thumbnail;
  List<String> pictures;
  String name;
  String sku;
  List<Map<String, dynamic>> categories;
  List<Map<String, dynamic>> groups;
  Map<String, dynamic> brand;
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
      brand: Map<String, dynamic>.from(map['brand']),
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
}
