import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/format.dart';

import 'package:flutter_back_end/models/product.dart';

class WidgetProduct extends StatelessWidget {
  final Product product;
  const WidgetProduct({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.11,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
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
                  imageUrl: product.thumbnail ??
                      'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
                  placeholder: (context, string) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            //* info sản phẩm
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
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
