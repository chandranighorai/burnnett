import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:flutter/material.dart';

import 'OrderDetails.dart';

class OrdersItem extends StatefulWidget {
  final OrderData orderData;

  const OrdersItem({Key key, this.orderData}) : super(key: key);
  @override
  _OrdersItemState createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 340;
    OrderData orderData = widget.orderData;
    //print("orderData..." + orderData..toString());
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDet(
              categoryID: orderData.myOrderDetails.productId,
              categoryName: orderData.myOrderDetails.productTitle,
              searchKeyword: "",
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              // border: Border.all(
              //     color: AppColors.loginContainerBorder,
              //     width: 1),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: Text(
                        orderData.myOrderDetails.productTitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                      ),
                      child: Text(
                        "\u20B9 " + orderData.orderTotalValue,
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   orderData.orderTotalValue,
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //   ),
                    // ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.0),
                  child: Image.network(
                    orderData.myOrderDetails.productImage,
                    height: 97,
                    width: 97,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            // child: orderData.myOrderDetails == "null"
            //     ? Container()
            //     : Text(orderData.myOrderDetails.productTitle,
            //         style: TextStyle(
            //           fontSize: 14,
            //           color: Colors.black,
            //         )),
          ),
        ],
      ),
    );
  }
}
