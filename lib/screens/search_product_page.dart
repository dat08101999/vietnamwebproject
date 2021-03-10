import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/widgets/widget_product.dart';

class SearchProduct extends StatefulWidget {
  final List<Product> listProduct;

  const SearchProduct({Key key, this.listProduct}) : super(key: key);

  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final controllerSearch = TextEditingController();
  List<Product> _listProductSearched;
  @override
  void initState() {
    super.initState();
    controllerSearch.addListener(() {
      search();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controllerSearch,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'nhập tên sản phẩm tìm kiếm',
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: controllerSearch.text.isNotEmpty == true
                          ? _listProductSearched.length
                          : widget.listProduct.length,
                      itemBuilder: (context, index) => WidgetProduct(
                          product: controllerSearch.text.isNotEmpty == true
                              ? _listProductSearched[index]
                              : widget.listProduct[index])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void search() {
    List<Product> _products = [];
    _products.addAll(widget.listProduct);
    if (controllerSearch.text.isNotEmpty) {
      _products.retainWhere((element) {
        String searchText = controllerSearch.text.toLowerCase();
        String name = element.name.toLowerCase();
        return name.contains(searchText);
      });
    }
    setState(() {
      _listProductSearched = _products;
    });
  }
}
