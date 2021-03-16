import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/product_controller.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/screens/variations_page.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:flutter_back_end/widgets/widget_dropdow_list.dart';
import 'package:flutter_back_end/widgets/widget_textformfield.dart';
import 'package:get/get.dart';
import 'package:flutter_back_end/models/categories_product.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/product.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  final bool readOnly;
  const ProductInfo({
    Key key,
    @required this.product,
    @required this.readOnly,
  }) : super(key: key);
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  ProductController _productController;
  var _firstValue;
  final key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _productController = Get.put(ProductController());
    _productController.getProductInfo(widget.product);
    _productController.idCategoriesSelected =
        widget.product.categories.length > 1
            ? widget.product.categories[0]['id']
            : 0;
    _firstValue = CategoriesProduct.fromMap(widget.product.categories.length > 1
        ? widget.product.categories[0]
        : null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông Tin Sản Phẩm'),
        centerTitle: true,
      ),
      body: Builder(
          builder: (context) => Container(
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
                                    controller:
                                        _productController.controllerTextName,
                                    icon: Icon(Icons.all_inbox_rounded),
                                    readonly: widget.readOnly),
                                WidgetTextFormField(
                                    title: 'Mã Sản Phẩm',
                                    controller:
                                        _productController.controllerTextID,
                                    readonly: true,
                                    icon: Icon(Icons.announcement)),
                                //* dropdow list
                                FutureBuilder(
                                    future: getCategoriesProduct(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<CategoriesProduct>
                                            _listCategoriesProduct =
                                            snapshot.data;
                                        return WidgetDropdowList(
                                            firstValue: _firstValue ??
                                                _listCategoriesProduct[0],
                                            listValue: _listCategoriesProduct,
                                            //* set Dropdow
                                            onChanged: (id) {
                                              if (!widget.readOnly) {
                                                _firstValue =
                                                    _listCategoriesProduct
                                                        .singleWhere(
                                                            (element) =>
                                                                element.id ==
                                                                id, orElse: () {
                                                  return null;
                                                });
                                                _productController
                                                    .idCategoriesSelected = id;
                                              }
                                            });
                                      } else {
                                        print(snapshot.error);
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                                //* end dropdow list
                                WidgetTextFormField(
                                    title: 'Mô Tả Ngắn',
                                    controller: _productController
                                        .controllerTextDescription,
                                    icon: Icon(Icons.article_outlined),
                                    maxLine: 5,
                                    readonly: widget.readOnly),
                                widget.product.variations.length == 0
                                    ? WidgetTextFormField(
                                        title: 'Giá Bán Gốc',
                                        controller: _productController
                                            .controllerTextPriceRegular,
                                        icon: Icon(Icons.attach_money_rounded),
                                        readonly: widget.readOnly)
                                    : Container(),
                                widget.product.variations.length == 0
                                    ? WidgetTextFormField(
                                        title: 'Giá Bán Hiện Tại',
                                        controller: _productController
                                            .controllerTextPriceSale,
                                        icon: Icon(Icons.attach_money_rounded),
                                        readonly: widget.readOnly,
                                      )
                                    : Container(),
                                WidgetTextFormField(
                                    title: 'Số Lượng Còn Lại',
                                    controller:
                                        _productController.controllerTextStock,
                                    readonly: true,
                                    icon: Icon(Icons.filter_alt_rounded))
                              ],
                            ),
                          ),
                        ),
                        widget.readOnly == false
                            ? Column(
                                children: [
                                  widget.product.variations.length > 0
                                      ? ButtonCustom.buttonSubmit(
                                          name: 'Danh Sách Biến Thể',
                                          onPress: () {
                                            Get.to(() => VariationsPage(
                                                  variations:
                                                      widget.product.variations,
                                                ));
                                          })
                                      : Container(),
                                  ButtonCustom.buttonSubmit(
                                      name: 'Cập Nhập Thông Tin',
                                      onPress: () async {
                                        this.toProduct();
                                        Product.updateProduct(
                                            widget.product, _productController);
                                      }),
                                ],
                              )
                            : Container(),
                      ],
                    );
                  },
                ),
              )),
    );
  }

  toProduct() {
    widget.product.name = _productController.controllerTextName.text;
    widget.product.priceRegular =
        int.parse(_productController.controllerTextPriceRegular.text);
    widget.product.priceSale =
        int.parse(_productController.controllerTextPriceSale.text);
    widget.product.description =
        _productController.controllerTextDescription.text;
  }
}

Future<List<CategoriesProduct>> getCategoriesProduct() async {
  var paramas = {
    'token': ControllerMainPage.webToken,
    'limit': 10,
    'offset': 0
  };
  List<CategoriesProduct> _list = [];

  var response = await RequestDio.get(
      url: ConfigsMywebvietnam.getCategoriesApi, parames: paramas);

  try {
    if (response['success']) {
      List _categoriesProduct = response['data'] ?? [];
      _categoriesProduct.forEach((element) {
        _list.add(CategoriesProduct.fromMap(element));
        if (element['child'] != null &&
            _list.indexWhere((elementWhere) =>
                    elementWhere.id == element['child']['id']) ==
                -1) {
          _list.add(CategoriesProduct.fromMap(element['child']));
        }
        if (element['child']['child'] != null &&
            element['child']['child'] is List<dynamic> &&
            element['child']['child'].length > 0) {
          element['child']['child'].forEach((elementChild) {
            if (_list.indexWhere((elementWhere) =>
                    elementWhere.id == element['child']['child']['id']) ==
                -1) _list.add(CategoriesProduct.fromMap(elementChild));
          });
        }
        if (element['child']['child'] != null &&
            element['child']['child'] is Map &&
            _list.indexWhere((elementWhere) =>
                    elementWhere.id == element['child']['child']['id']) ==
                -1) {
          _list.add(CategoriesProduct.fromMap(element['child']['child']));
        }
      });
      return _list;
    } else {
      print('lấy dữ liệu lỗi');
      return null;
    }
  } catch (e, trace) {
    print(trace);
    return null;
  }
}
