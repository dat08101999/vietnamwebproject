class Blog {
  int id;
  String thumbnail;
  String name;
  int view;
  String link;
  String addedDate;
  Map<String, dynamic> categories;
  String test111111;

  Blog({
    this.id,
    this.thumbnail,
    this.name,
    this.view,
    this.link,
    this.addedDate,
    this.categories,
    this.test111111,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'name': name,
      'view': view,
      'link': link,
      'addedDate': addedDate,
      'categories': categories,
      'test111111': test111111,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Blog(
      id: map['id'],
      thumbnail: map['thumbnail'],
      name: map['name'],
      view: map['view'],
      link: map['link'],
      addedDate: map['added_date'],
      categories: Map<String, dynamic>.from(map['categories']),
      test111111: map['test111111'],
    );
  }

  @override
  String toString() {
    return 'Blog(id: $id, thumbnail: $thumbnail, name: $name, view: $view, link: $link, addedDate: $addedDate, categories: $categories)';
  }
}
