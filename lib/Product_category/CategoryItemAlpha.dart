import 'package:burnett/Home/ProductDataModel.dart';
import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:flutter/material.dart';

import 'CategoryAlpha.dart';
import 'ProductCategoryDetails.dart';
import 'ProductModelCategory.dart';

class CategoryItemAlpha extends StatefulWidget {
  final CategoryAlpha categorydata;
  final Function() notifyParent;
  final Function(String index) sortItem;
  const CategoryItemAlpha(
      {Key key, this.categorydata, this.notifyParent, this.sortItem})
      : super(key: key);
  @override
  _CategoryItemAlphaState createState() => _CategoryItemAlphaState();
}

class _CategoryItemAlphaState extends State<CategoryItemAlpha> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 140;
    CategoryAlpha categorydata = widget.categorydata;
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductCategoryDetails(
        //       categorydata: categorydata
        //     ),
        //   ),
        // );
        _handleSort(categorydata.alphKey);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                categorydata.alphKey,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }

  _handleSort(String item) {
    widget.notifyParent();
    widget.sortItem(item);
  }
}
