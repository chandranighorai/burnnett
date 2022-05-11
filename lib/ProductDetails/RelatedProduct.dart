import 'dart:ui';

import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/ProductDetails/ProductModel.dart';
import 'package:flutter/material.dart';

class RelatedProduct extends StatefulWidget {
  RelatedProductList relatedData;
  String baseUrl;
  RelatedProduct({this.relatedData, this.baseUrl, Key key}) : super(key: key);

  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  @override
  Widget build(BuildContext context) {
    var url =
        widget.baseUrl.toString() + widget.relatedData.productImage.toString();
    print("url..." + url.toString());
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDet(
                categoryID: widget.relatedData.productId,
                categoryName: widget.relatedData.productTitle,
                searchKeyword: "",
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 45,
          width: 120,
          //color: Colors.white,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
                    image: DecorationImage(
                        image: NetworkImage(url), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(widget.relatedData.productTitle.toString()),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                "\u20B9 ${widget.relatedData.productPrice.toString()}",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
