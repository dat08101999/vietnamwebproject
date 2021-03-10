import 'dart:convert';

class CategoriesProduct {
  String name;
  int id;
  String url;
  String thumbnail;
  String keyword;
  String description;
  dynamic child;
  CategoriesProduct({
    this.name,
    this.id,
    this.url,
    this.thumbnail,
    this.keyword,
    this.description,
    this.child,
  });

  CategoriesProduct copyWith({
    String name,
    int id,
    String url,
    String thumbnail,
    String keyword,
    String description,
    dynamic child,
  }) {
    return CategoriesProduct(
      name: name ?? this.name,
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnail: thumbnail ?? this.thumbnail,
      keyword: keyword ?? this.keyword,
      description: description ?? this.description,
      child: child ?? this.child,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'url': url,
      'thumbnail': thumbnail,
      'keyword': keyword,
      'description': description,
      'child': child,
    };
  }

  factory CategoriesProduct.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoriesProduct(
      name: map['name'],
      id: map['id'],
      url: map['url'],
      thumbnail: map['thumbnail'],
      keyword: map['keyword'],
      description: map['description'],
      child: map['child'] is String
          ? map['child']
          : map['child'] != null
              ? Map<String, dynamic>.from(map['child'])
              : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesProduct.fromJson(String source) =>
      CategoriesProduct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoriesProduct(name: $name, id: $id, url: $url, thumbnail: $thumbnail, keyword: $keyword, description: $description, child: $child)';
  }
}
