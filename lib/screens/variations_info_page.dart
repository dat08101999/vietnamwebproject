import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_imagereading.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:flutter_back_end/widgets/widget_imagelocalread.dart';
import 'package:flutter_back_end/widgets/widget_show_notifi.dart';
import 'package:flutter_back_end/widgets/widget_textformfield.dart';
import 'package:get/get.dart';

class VariationPage extends StatefulWidget {
  final variations;
  VariationPage(this.variations);

  @override
  _VariationPageState createState() => _VariationPageState(variations);
}

class _VariationPageState extends State<VariationPage> {
  final variations;
  _VariationPageState(this.variations);
  TextEditingController _name = TextEditingController();

  TextEditingController _price = TextEditingController();

  TextEditingController _saleprice = TextEditingController();

  TextEditingController _sku = TextEditingController();

  TextEditingController _stock = TextEditingController();
  onLoad() {
    _name.text = widget.variations['name'] ?? '';
    _price.text = widget.variations['price_regular'].toString() ?? '';
    _sku.text = widget.variations['sku'].toString() ?? '';
    _saleprice.text = widget.variations['price_sale'].toString() ?? '';
    _stock.text = widget.variations['stock'].toString() ?? '';
  }

  @override
  initState() {
    onLoad();
    super.initState();
  }

  Widget buildBody() {
    return ListView(
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
        ButtonCustom.buttonSubmit(
            name: 'Cập Nhập Thông Tin',
            onPress: () async {
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
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variations != null)
      return Scaffold(
        appBar: AppBar(),
        body: buildBody(),
      );
    return Text('Không có dữ liệu');
  }
}
