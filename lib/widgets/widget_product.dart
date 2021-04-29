import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/format.dart';
import 'package:flutter_back_end/models/loading.dart';

import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/screens/product_info_page.dart';
import 'package:get/get.dart';

class WidgetProduct extends StatelessWidget {
  final Product product;
  const WidgetProduct({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Loading.show();
        Product _product = await Product.getProduct(this.product.id.toString());
        Loading.dismiss();
        if (_product != null)
          Get.to(() => ProductInfo(product: _product, readOnly: false));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 3,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: ListTile(
            //* ảnh sản phẩm
            leading: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: product.thumbnail ?? ConfigsMywebvietnam.urlNoImage,
                  placeholder: (context, string) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  errorWidget: (context, string, dynamic) =>
                      Image.network(ConfigsMywebvietnam.urlNoImage),
                ),
              ),
            ),
            //* info sản phẩm
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    product.name,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //* số lượng
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Số lượng còn lại : ',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: product.stock.toString(),
                      style: TextStyle(color: Colors.black54))
                ])),
                //* giá bán
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Giá bán hiện tại: ',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: Format.moneyFormat(product.priceSale.toString()),
                      style: TextStyle(color: Colors.red))
                ])),
              ],
            )),
      ),
    );
  }
}
