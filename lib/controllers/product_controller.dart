import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_back_end/models/categories_product.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:get/get.dart' show GetxController;

class ProductController extends GetxController {
  TextEditingController controllerTextName = TextEditingController();
  TextEditingController controllerTextID = TextEditingController();
  TextEditingController controllerTextPriceRegular = TextEditingController();
  TextEditingController controllerTextPriceSale = TextEditingController();
  TextEditingController controllerTextStock = TextEditingController();
  TextEditingController controllerTextDescription = TextEditingController();
  int _limit = 0;
  static int _idCategoriesSelected = 0;

  int get idCategoriesSelected => _idCategoriesSelected;

  set idCategoriesSelected(int idCategoriesSelected) {
    _idCategoriesSelected = idCategoriesSelected;
    update();
  }

  int get limit => _limit;

  set limit(int limit) {
    _limit += limit;
    update();
  }

  getProductInfo(Product product) {
    if (product != null) {
      controllerTextName.text = product.name;
      controllerTextID.text = product.sku ?? product.id.toString();
      controllerTextPriceRegular.text = product.priceRegular.toString();
      controllerTextPriceSale.text = product.priceSale.toString();
      controllerTextStock.text = product.stock.toString();
      controllerTextDescription.text = product.description;
    }
  }
}

class ControllerAddCategories extends GetxController {
  List<CategoriesProduct> categories = List<CategoriesProduct>();
  addCategories(CategoriesProduct category) {
    if (checkContains(category)) return;
    categories.add(category);
    update();
  }

  bool checkContains(CategoriesProduct category) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i].id == category.id) {
        return true;
      }
    }
    return false;
  }

  removeCategories(CategoriesProduct product) {
    categories.remove(product);
    update();
  }
}
