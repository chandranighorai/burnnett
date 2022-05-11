import 'dart:convert';

import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/util/Consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'WishListModel.dart';
import 'package:http/http.dart' as http;

class AllWishlist extends StatefulWidget {
  final WishListModel wishListModel;
  final Function() notifyParent;
  final Function(int index) delItem;
  final int itemIndex;
  const AllWishlist(
      {Key key,
      this.wishListModel,
      this.notifyParent,
      this.delItem,
      this.itemIndex})
      : super(key: key);
  @override
  _AllWishlistState createState() => _AllWishlistState();
}

class _AllWishlistState extends State<AllWishlist> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 140;
    WishListModel wishListModel = widget.wishListModel;
    print("wishList Model..." + wishListModel.productTitle);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDet(
              categoryID: wishListModel.productId,
              categoryName: wishListModel.productTitle,
              searchKeyword: "",
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.02))),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(wishListModel.productImage))),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(wishListModel.productTitle),
              Spacer(),
              InkWell(
                onTap: (() => _handleremoveWish(
                    wishListModel, "remove", widget.itemIndex)),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.06,
                  child: Image(
                    image: AssetImage(
                      "images/ic_wishlistActive.png",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Container(
      //   height: MediaQuery.of(context).size.width * 0.3,
      //   width: MediaQuery.of(context).size.width,
      //   decoration: BoxDecoration(
      //     color: Colors.red,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.5),
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: Offset(0, 3),
      //         // changes position of shadow
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     children: [
      //       ClipRRect(
      //         borderRadius: BorderRadius.circular(9.0),
      //         child: Image.network(
      //           wishListModel.productImage,
      //           height: containerWidth,
      //           width: containerWidth,
      //           fit: BoxFit.cover,
      //           errorBuilder: (BuildContext context, Object exception,
      //               StackTrace stackTrace) {
      //             return Container();
      //           },
      //           loadingBuilder: (BuildContext context, Widget child,
      //               ImageChunkEvent loadingProgress) {
      //             if (loadingProgress == null) return child;
      //             return Container(
      //               height: containerWidth,
      //               width: containerWidth,
      //               child: Center(
      //                 child: SizedBox(
      //                   height: 20,
      //                   width: 20,
      //                   child: CircularProgressIndicator(
      //                     valueColor: new AlwaysStoppedAnimation<Color>(
      //                       Colors.grey,
      //                     ),
      //                     strokeWidth: 2,
      //                     value: loadingProgress.expectedTotalBytes != null
      //                         ? loadingProgress.cumulativeBytesLoaded /
      //                             loadingProgress.expectedTotalBytes
      //                         : null,
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 0.0),
      //             child: Text(
      //               wishListModel.productTitle,
      //               style: TextStyle(
      //                 fontSize: 14,
      //                 color: Colors.black,
      //               ),
      //             ),
      //           ),
      //           Spacer(),
      //           InkWell(
      //             onTap: (() => _handleremoveWish(
      //                 wishListModel, "remove", widget.itemIndex)),
      //             child: Image(
      //               image: AssetImage("images/ic_wishlistActive.png"),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  _handleremoveWish(
      WishListModel wishListModel, String action, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&product_id=" + wishListModel.productId;
    requestParam += "&action=" + action;
    print(user_id);
    final http.Response response = await http.get(
      Uri.parse(Consts.ADD_TO_WISHLIST + requestParam),
    );
    // print(requestParam);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverMessage = responseData['status'];
      if (serverMessage == "success") {
        print(responseData);
        widget.delItem(index);
      }
    }
  }
}
