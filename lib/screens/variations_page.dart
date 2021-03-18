import 'package:flutter/material.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/screens/variations_info_page.dart';
import 'package:flutter_back_end/widgets/widget_variations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class VariationsPage extends StatelessWidget {
  final Product product;
  VariationsPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biến Thể Sản Phẩm'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Get.to(() => VariationInfoPage(
                      isAdd: true,
                      idProdcut: product.id.toString(),
                    ));
              })
        ],
      ),
      body: Container(
          height: 400,
          child: ListView.builder(
            itemCount: product.variations.length,
            itemBuilder: (context, index) => _buildItem(
                WidgetVariations(
                  variation: product.variations[index],
                ),
                product.variations[index]),
          )),
    );
  }

  Widget _buildItem(
    Widget child,
    dynamic item,
  ) =>
      Slidable(
        child: child,
        secondaryActions: [
          IconSlideAction(
              caption: 'Xóa',
              color: Colors.red[400],
              icon: Icons.delete,
              onTap: () async {
                var delete = await showDialog(
                  context: currentContext,
                  builder: (context) => AlertDialog(
                    title: Text('Xác Nhận'),
                    content: Text('Biến thể này sẽ bị xóa ?'),
                    actions: [
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('Đồng Ý')),
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Hủy Bỏ')),
                    ],
                  ),
                );
                if (delete) {}
              })
        ],
        actionPane: SlidableDrawerActionPane(),
      );
}
