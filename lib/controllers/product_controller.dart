import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_back_end/models/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  TextEditingController controllerTextName = TextEditingController();
  TextEditingController controllerTextID = TextEditingController();
  TextEditingController controllerTextPriceRegular = TextEditingController();
  TextEditingController controllerTextPriceSale = TextEditingController();
  TextEditingController controllerTextStock = TextEditingController();
  TextEditingController controllerTextContent = TextEditingController();
  int _limit = 0;
  static int _idCategoriesSelected = 0;

  int get idCategoriesSelected => _idCategoriesSelected;

  set idCategoriesSelected(int idCategoriesSelected) {
    _idCategoriesSelected = idCategoriesSelected;
    update();
  }

  int get limit => _limit;

  set limit(int limit) {
    _limit = limit;
    update();
  }

  getProductInfo(Product product) {
    if (product != null) {
      controllerTextName.text = product.name;
      controllerTextID.text = product.sku ?? product.id.toString();
      controllerTextPriceRegular.text = product.priceRegular.toString();
      controllerTextPriceSale.text = product.priceSale.toString();
      controllerTextStock.text = product.stock.toString();
      controllerTextContent.text = product.content;
      update();
    }
  }
}
