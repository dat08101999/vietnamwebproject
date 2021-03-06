import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/product_controller.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:flutter_back_end/widgets/widget_textformfield.dart';
import 'package:get/get.dart';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/product.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  ProductController _productController;
  @override
  void initState() {
    super.initState();
    _productController = Get.put(ProductController());
    _productController.getProductInfo(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin Sản Phẩm'),
        centerTitle: true,
      ),
      body: Container(
        child: GetBuilder<ProductController>(
          builder: (ctl) {
            return Column(
              children: [
                //* title
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    ConfigsMywebvietnam.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                //* info sản phẩm
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(5),
                    child: ListView(
                      children: [
                        WidgetTextFormField(
                            title: 'Tên Sản Phẩm',
                            controller: _productController.controllerTextName,
                            icon: Icon(Icons.edit)),
                        WidgetTextFormField(
                            title: 'Mã Sản Phẩm',
                            controller: _productController.controllerTextID,
                            readonly: true,
                            icon: Icon(Icons.edit)),
                        WidgetTextFormField(
                            title: 'Giá Bán Gốc',
                            controller:
                                _productController.controllerTextPriceRegular,
                            icon: Icon(Icons.edit)),
                        WidgetTextFormField(
                            title: 'Giá Bán Hiện Tại',
                            controller:
                                _productController.controllerTextPriceSale,
                            icon: Icon(Icons.edit)),
                        WidgetTextFormField(
                            title: 'Số Lượng Còn Lại',
                            controller: _productController.controllerTextStock,
                            readonly: true,
                            icon: Icon(Icons.edit))
                      ],
                    ),
                  ),
                ),
                ButtonCustom.buttonSubmit(
                    name: 'Cập Nhập Thông Tin', onPress: () {})
              ],
            );
          },
        ),
      ),
    );
  }
}
