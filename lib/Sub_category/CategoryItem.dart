import 'package:burnett/Home/ProductDataModel.dart';
import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/Product_category/ProductCategoryDetails.dart';
import 'package:flutter/material.dart';

import 'ProductModelCategory.dart';

class CategoryItem extends StatefulWidget {
  final Category categorydata;

  const CategoryItem({Key key, this.categorydata}) : super(key: key);
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 140;
    Category categorydata = widget.categorydata;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductCategoryDetails(categoryID: categorydata.catId),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.14,
                      //color: Colors.red,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.network(
                          categorydata.categoryImage,
                          height: 40,
                          width: 40,
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
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                      Colors.grey,
                                    ),
                                    strokeWidth: 2,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        //color: Colors.amber,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          categorydata.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Divider(
              color: Colors.black,
            )
            // Container(
            //   height: 1,
            //   color: Colors.black12,
            // )
          ],
        ),
      ),
    );
  }
}
