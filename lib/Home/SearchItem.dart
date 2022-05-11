import 'package:burnett/Home/SearchModel.dart';
import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatefulWidget {
  Productdata searchItems;
  SearchItem({this.searchItems, Key key}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    var url = widget.searchItems.baseUrl + widget.searchItems.productImage;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // print("categoryId..." + widget.searchItems.productId);
          // print("categoryId..." + widget.searchItems.productTitle);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDet(
                        categoryID: widget.searchItems.productId,
                        categoryName: widget.searchItems.productTitle,
                        searchKeyword: "",
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.02))),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02)),
                    image: DecorationImage(
                        image: NetworkImage(url), fit: BoxFit.fill)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.searchItems.productTitle),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                    widget.searchItems.productType == "variable"
                        ? "\u20B9 ${widget.searchItems.productAttribute[0].productPrice}"
                        : "\u20B9 ${widget.searchItems.productPrice}",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
