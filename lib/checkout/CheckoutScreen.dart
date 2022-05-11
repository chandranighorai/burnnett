import 'dart:convert';

import 'package:burnett/Address/AddAddress.dart';
import 'package:burnett/Address/AddressModel.dart';
import 'package:burnett/Address/AllAdressScreen.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/shopping_cart/ShoppingCartScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util/AppColors.dart';
import '../util/Consts.dart';
import '../util/Util.dart';

class CheckoutScreen extends StatefulWidget {
  final int cartQuantity;
  final int couponId;
  final double shippingCost;
  final double tax;
  final double totalAmpount;
  final double subTotalAmpount;
  final double couponAmount;
  const CheckoutScreen({
    Key key,
    this.cartQuantity,
    this.couponId,
    this.shippingCost,
    this.tax,
    this.totalAmpount,
    this.subTotalAmpount,
    this.couponAmount,
  }) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<AddressModel> _mAddressList;
  Future<List<AddressModel>> _addressList;
  AddressModel defaultAddress;

  String selectedAddress;
  String selectedPaymmentMethod;
  bool isPaid;
  String addressId;

  int couponId;
  double taxAmount;
  double shippingCost;
  double totalAmpount;
  double subTotalAmpount;
  double couponAmount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedAddress = " Azhar, Sdf building";
    selectedPaymmentMethod = "COD";

    _addressList = _getAddress();
    isPaid = true;
    addressId = "";
    defaultAddress = new AddressModel();

    couponId = widget.couponId;
    taxAmount = widget.tax;
    shippingCost = widget.shippingCost;
    totalAmpount = widget.totalAmpount;
    subTotalAmpount = widget.subTotalAmpount;
    couponAmount = widget.couponAmount;
  }

  // ==============
  _changePaymentMethod(String paymentMethod) {
    setState(() {
      selectedPaymmentMethod = paymentMethod;
      if (selectedPaymmentMethod == "COD") {
        isPaid = true;
      } else {
        isPaid = false;
      }
    });
  }

  Future<List<AddressModel>> _getAddress() async {
    double totalPrice = 0;
    List<AddressModel> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    final http.Response response = await http.get(
      Uri.parse(Consts.USER_ADDRESSES_LIST + requestParam),
    );
    print(Consts.USER_ADDRESSES_LIST + requestParam);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverMessage = responseData['status'];
      var arrAddress = responseData["userdata"];
      print(responseData);
      if (responseData['status'] == "success") {
        if (arrAddress.length > 0) {
          for (int i = 0; i < arrAddress.length; i++) {
            var itemData = arrAddress[i];
            print(itemData);
            if (itemData['default_billing'] == "1") {
              AddressModel item = AddressModel();
              // var productDetails =itemData['productdata'];
              item.id = itemData['id'];
              setState(() {
                addressId = item.id;
              });
              item.userId = itemData['user_id'];
              item.defaultBilling = itemData['default_billing'];
              item.name = itemData['name'];
              item.phone = itemData['phone'];
              item.pincode = itemData['pincode'];
              item.flatHouseFloorBuilding =
                  itemData['flat_house_floor_building'];
              item.locality = itemData['locality'];
              item.landmark = itemData['landmark'];
              item.city = itemData['city'];
              item.state = itemData['state'];
              item.country = itemData['country'];
              item.country = itemData['country'];
              item.addressType = itemData['address_type'];
              setState(() {
                defaultAddress = item;
              });
              mList.add(item);
            }
          }
        }
      } else {
        showCustomToast(serverMessage);
        return null;
      }
    } else {
      showCustomToast("Something went wrong.\nPlease try again.");
      return null;
    }
    debugPrint("Address Size ${mList.length}");
    return mList;
  }

  _addAdress() async {
    var newAddress = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => AddAddress(),
          fullscreenDialog: true,
        ));

    debugPrint("Returned data ${newAddress['id']} ${newAddress['address']}");
    if (newAddress != null) {
      setState(() {
        selectedAddress = newAddress['address'];
      });
    }
  }

  _showSuccessDialog(String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await showDialog(
            context: context,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogBackgroundColor: Colors.white,
                ),
                child: AlertDialog(
                  title: null,
                  content: StatefulBuilder(
                    // You need this, notice the parameters below:
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 60,
                            color: AppColors.appMainColor,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "You can track your order from my order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Checkout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            });
      },
    );
  }

  _placeOrder() async {
    if (!isPaid) {
      showCustomToast("Please select payment method");
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var addressId = defaultAddress.id;

    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&address_id=" + addressId;
    requestParam += "&total_amount=" + totalAmpount.toString();
    requestParam += "&subtotal_value=" + subTotalAmpount.toString();
    requestParam += "&coupon_amount=" + couponAmount.toString();
    requestParam += "&coupon_id=" + couponId.toString();
    requestParam += "&shipping_cost=" + shippingCost.toString();

    final http.Response response = await http.get(
      Uri.parse(Consts.placeOrder + requestParam),
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverStatus = responseData['status'];
      var serverMessage = responseData['message'];
      if (serverStatus == "success") {
        debugPrint(Consts.placeOrder + requestParam);
        _showSuccessDialog(serverMessage);
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      showCustomToast(Consts.SERVER_NOT_RESPONDING);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pop(context);
            FocusScope.of(context).unfocus();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(),
              ),
            );
          },
        ),
        backgroundColor: AppColors.appBannerColor,
        title: Text(
          "Burnett",
          style: TextStyle(
            fontFamily: "Philosopher",
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                customShape(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.checkoutDeliveryHeadingColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _addAdress();
                              },
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: AppColors.checkoutAddDeleiverColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                          initialData: null,
                          future: _addressList,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              _mAddressList = snapshot.data;
                              return _mAddressList.length <= 0
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors
                                              .checkoutAddDeleiverColor,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 15.0,
                                          bottom: 15.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "${defaultAddress.flatHouseFloorBuilding} ${defaultAddress.locality} "
                                                    "${defaultAddress.landmark} \n ${defaultAddress.city} - ${defaultAddress.pincode}",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .checkoutAddressColor,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: 50,
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      size: 25,
                                                      color: defaultAddress
                                                                  .defaultBilling ==
                                                              "1"
                                                          ? AppColors
                                                              .checkoutAddDeleiverColor
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _viewAllAdresses();
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Payment Methods",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.checkoutDeliveryHeadingColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _changePaymentMethod("COD");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFF1F1F1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "COD",
                                        style: TextStyle(
                                          color: AppColors
                                              .checkoutAddDeleiverColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "(Cash On Delivery)",
                                        style: TextStyle(
                                          color: AppColors
                                              .checkoutDeliveryHeadingColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 50,
                                    child: selectedPaymmentMethod == "COD"
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 25,
                                            color: AppColors
                                                .checkoutAddDeleiverColor,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     _changePaymentMethod("PAYTM");
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(color: Color(0XFFF1F1F1)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 15.0,
                        //         vertical: 25,
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           new SizedBox(
                        //             height: 25.0,
                        //             child: Image.asset(
                        //               "images/paytm_logo.png",
                        //               fit: BoxFit.contain,
                        //             ),
                        //           ),
                        //           Container(
                        //             width: 50,
                        //             child: selectedPaymmentMethod == "PAYTM"
                        //                 ? Icon(
                        //                     Icons.check_circle,
                        //                     size: 25,
                        //                     color: AppColors
                        //                         .checkoutAddDeleiverColor,
                        //                   )
                        //                 : Icon(
                        //                     Icons.check_circle,
                        //                     size: 25,
                        //                     color: Colors.grey,
                        //                   ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _changePaymentMethod("RAZOR");
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Color(0XFFF1F1F1)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  new SizedBox(
                                    width: 90.0,
                                    child: Image.asset(
                                      "images/razor_logo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: selectedPaymmentMethod == "RAZOR"
                                        ? Icon(
                                            Icons.check_circle,
                                            size: 25,
                                            color: AppColors
                                                .checkoutAddDeleiverColor,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            size: 25,
                                            color: Colors.grey,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  _placeOrder();
                                },
                                child: Text(
                                  'Place Order',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // final double shapeHeight = 140;
  Widget customShape() {
    return ClipPath(
      // clipper: RedShape(MediaQuery.of(context).size.width, shapeHeight),
      child: Container(
        // height: shapeHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 35,
            right: 35,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Checkout",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${widget.cartQuantity} items",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _viewAllAdresses() async {
    var dataReturned = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllAdressScreen(
          mAddressList: _mAddressList,
        ),
      ),
    );

    setState(() {
      defaultAddress = dataReturned;
    });

    print(defaultAddress.flatHouseFloorBuilding);
    // _getAddress();
  }
}
