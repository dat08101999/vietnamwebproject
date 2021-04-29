class Format {
  static String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return '$value';
    }
    return '$price';
  }

  static String dateFormat(DateTime source) {
    return source.day.toString() +
        '/' +
        source.month.toString() +
        '/' +
        source.year.toString();
  }
}
