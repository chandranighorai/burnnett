import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:flutter/material.dart';

import 'ProductDataModel.dart';

class CategoryItem extends StatefulWidget {
  final Productdata productdata;

  const CategoryItem({Key key, this.productdata}) : super(key: key);
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 140;
    Productdata productData = widget.productdata;
    print("productImage..." + productData.productcatimg.toString());
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDet(
              categoryID: productData.productId,
              categoryName: productData.productTitle,
              searchKeyword: "",
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(9),
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset.zero,
                blurRadius: 6.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.network(
                  productData.productcatimg,
                  height: containerWidth,
                  width: containerWidth,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Container();
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: containerWidth,
                      width: containerWidth,
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.grey,
                            ),
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  productData.productTitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
