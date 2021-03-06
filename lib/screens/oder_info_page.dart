import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/format.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/widgets/widget_dialog_info_customer.dart';

class OrderInfo extends StatefulWidget {
  final Order order;
  OrderInfo({this.order});
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
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
              //* info khách hàng
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Khách Hàng',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg'),
                      ),
                      title: Text(
                        widget.order.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        widget.order.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => DialogInfoCustomer(
                                    order: widget.order,
                                  ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //* Danh Sách Sản Phẩm
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Sản Phẩm',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.order.product.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                imageUrl: widget.order.product[index]
                                        ['thumbnail'] ??
                                    'https://thumbs.dreamstime.com/b/no-image-available-icon-vector-illustration-flat-design-140476186.jpg',
                                placeholder: (context, string) => Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            title: Text(
                              widget.order.product[index]['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(Format.moneyFormat(widget
                                .order.product[index]['price']
                                .toString())),
                            trailing: Text(
                              widget.order.product[index]['quantity']
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // //* Thanh toán
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Thanh Toán',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tổng giá sản phẩm'),
                            Text('Phí vận chuyển'),
                            Text('Số tiền đã giảm'),
                            Text('Số tiền thanh toán'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(Format.moneyFormat(
                                widget.order.amount['money'].toString())),
                            Text(Format.moneyFormat(
                                widget.order.amount['shipfee'].toString())),
                            Text(
                              Format.moneyFormat(
                                  widget.order.amount['discount'].toString()),
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              Format.moneyFormat(
                                  widget.order.amount['payment'].toString()),
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}