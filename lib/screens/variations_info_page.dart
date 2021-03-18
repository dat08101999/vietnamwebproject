import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_imagereading.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:flutter_back_end/widgets/widget_imagelocalread.dart';
import 'package:flutter_back_end/widgets/widget_show_notifi.dart';
import 'package:flutter_back_end/widgets/widget_textformfield.dart';
import 'package:get/get.dart';

class VariationInfoPage extends StatefulWidget {
  final bool isAdd;
  final Map<String, dynamic> variation;
  final String idProdcut;

  const VariationInfoPage(
      {Key key, this.variation, @required this.isAdd, this.idProdcut})
      : super(key: key);

  @override
  _VariationPageState createState() => _VariationPageState(variation);
}

class _VariationPageState extends State<VariationInfoPage> {
  final variations;
  _VariationPageState(this.variations);
  TextEditingController _name = TextEditingController();

  TextEditingController _price = TextEditingController();

  TextEditingController _saleprice = TextEditingController();

  TextEditingController _sku = TextEditingController();

  TextEditingController _stock = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  onLoad() {
    if (variations != null) {
      _name.text = widget.variation['name'] ?? '';
      _price.text = widget.variation['price_regular'].toString() ?? '';
      _sku.text = widget.variation['sku'].toString() ?? '';
      _saleprice.text = widget.variation['price_sale'].toString() ?? '';
      _stock.text = widget.variation['stock'].toString() ?? '';
    }
  }

  @override
  initState() {
    onLoad();
    super.initState();
  }

  Widget buildBody() {
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                WidgetTextFormField(
                  controller: _name,
                  title: 'Tên biến thể',
                ),
                WidgetTextFormField(
                  controller: _sku,
                  title: 'Mã sku',
                ),
                WidgetTextFormField(
                  controller: _stock,
                  title: 'Số lượng',
                  isNumberField: true,
                ),
                WidgetTextFormField(
                  controller: _price,
                  title: 'Giá Bán',
                  isNumberField: true,
                ),
                WidgetTextFormField(
                  controller: _saleprice,
                  title: 'Giảm giá',
                  isNumberField: true,
                ),
                WidgetReadimage(),
              ],
            ),
          ),
        ),
        ButtonCustom.buttonSubmit(
            title: Text(
              widget.isAdd == false ? 'Cập Nhập Thông Tin' : 'Thêm Mới',
              style: TextStyle(color: Colors.white),
            ),
            onPress: () async {
              if (!_formKey.currentState.validate()) {
                return;
              }
              if (!widget.isAdd) {
                Loading.show(newTitle: 'vui lòng chờ ');
                var response = await Product.updateVariation(
                    variations['id'],
                    {
                      'name': _name.text,
                      'stock': _stock.text,
                      'variation_sku': _sku.text,
                      'price': _price.text,
                      'price_sale': _saleprice.text,
                    },
                    Get.find<ControllerReadImage>().imageChosenLink);

                Loading.dismiss();
                ShowNotifi.showToast(title: response['message']);
              } else {
                Loading.show(newTitle: 'vui lòng chờ ');
                var response = await Product.addVariation({
                  'item_id': widget.idProdcut,
                  'variations[0][name]': _name.text,
                  'variations[0][stock]': _stock.text,
                  'variations[0][variation_sku]': _sku.text,
                  'variations[0][price]': _price.text,
                  'variations[0][price_sale]': _saleprice.text,
                }, Get.find<ControllerReadImage>().imageChosenLink);
                Loading.dismiss();
                if (response['success'])
                  ShowNotifi.showToast(title: 'Thêm mới thành công !');
                else
                  ShowNotifi.showToast(
                      title: 'Thất bại ! hãy kiểm tra lại thông tin');
              }
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cập Nhập Biến Thể'),
        ),
        body: buildBody());
  }
}
