import 'dart:convert';

import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/Product_category/ProductModel.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util/Consts.dart';

class ItemProduct extends StatefulWidget {
  final ProductModel itemProduct;
  // final WishListModel wishListModel;

  const ItemProduct({
    Key key,
    this.itemProduct,
  }) : super(key: key);
  @override
  _ItemProductState createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isWish;
  ProductModel itemProduct;
  var requestParam;
  // bool _showLoder;

  @override
  initState() {
    super.initState();
    itemProduct = widget.itemProduct;
    isWish = itemProduct.isInWishList == 1 ? true : false;
  }

  wishAdd(bool isWish, ProductModel itemProduct) async {
    print(isWish);
    var addwis = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    if (isWish) {
      addwis = "add";
    } else {
      addwis = "remove";
    }
    requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&product_id=" + itemProduct.productId;
    requestParam += "&action=" + addwis;
    print(Consts.ADD_TO_WISHLIST + requestParam);
    final http.Response response = await http.get(
      Uri.parse(Consts.ADD_TO_WISHLIST + requestParam),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverCode = responseData['code'];
      var serverMessage = responseData['message'];
      if (serverCode == "200") {
        showCustomToast(serverMessage);
        setState(() {
          widget.itemProduct.isInWishList = isWish ? 1 : 0;
        });
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      showCustomToast(Consts.SERVER_NOT_RESPONDING);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDet(),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0XFFf9f7f7),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFf9f7f7),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          itemProduct.productImage,
                          height: 100.0,
                          width: 100.0,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Container();
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 100.0,
                              width: 100.0,
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
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemProduct.productTitle,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF0D0D0D),
                              ),
                              softWrap: true,
                            ),
                            Text(
                              "\u20B9 ${itemProduct.productPrice}",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFFD20014),
                              ),
                            ),
                            Text(
                              "${itemProduct.brandName}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF0D0D0D),
                              ),
                              softWrap: true,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // _productListwish
                                  InkWell(
                                    onTap: () => {
                                      // if(isWish==true){
                                      setState(
                                        () {
                                          isWish = !isWish;
                                        },
                                      ),
                                      wishAdd(isWish, itemProduct),

                                      // wishAdd(),
                                    },
                                    child: itemProduct.isInWishList == 1
                                        ? Image.asset(
                                            "images/ic_wishlistActive.png",
                                            height: 30,
                                          )
                                        : Image.asset(
                                            "images/ic_wishlist.png",
                                            height: 30,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Image.asset(
                                      "images/busket.png",
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 15,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 15.0),
            //     child: Container(
            //       height: 50,
            //       width: 50,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.appMainColor,
            //       ),
            //       child: Icon(
            //         Icons.shop,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
