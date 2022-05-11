import 'dart:convert';

import 'package:burnett/Address/AddAddress.dart';
import 'package:burnett/Address/AddressModel.dart';
import 'package:burnett/Address/AllAdressScreen.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/Product_category/ProductModel.dart';
import 'package:burnett/checkout/CheckoutScreen.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../shopping_cart/ItemShoppingCart.dart';
import '../util/AppColors.dart';
import '../util/Consts.dart';
import 'ShoppingCartModel.dart';

class ShoppingCartScreen extends StatefulWidget {
  final ProductModel itemProduct;

  const ShoppingCartScreen({Key key, this.itemProduct}) : super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  String _offers;
  bool hasItemsInCart;
  bool isApiCalled;
  Future<List<ShoppingCartModel>> _productList;
  List<ShoppingCartModel> mProductList;
  double shippingCharge;
  double taxAmount;
  double totalAmount;
  double promoAmount;
  String promoApplied;
  String paymentMethod;
  int couponId;

  TextStyle headingtextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.myAccountHeadingColor,
    fontWeight: FontWeight.bold,
  );
  TextStyle bottomLinktextStyle = TextStyle(
    fontSize: 15,
    color: AppColors.myAccountTextColor,
    fontWeight: FontWeight.bold,
  );
  String _searchKey = "";
  bool openSearch;
  var _searchController = new TextEditingController();
  AddressModel defaultAddress;
  Future<List<AddressModel>> _addressList;
  String userFName;
  String userLName;
  String quentity;
  double _subTotalPrice;
  String addressId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offers = "Test";
    hasItemsInCart = false;
    _searchKey = "";
    openSearch = false;
    mProductList = [];
    _productList = _handleFetchCart();
    _addressList = _getAddress();
    _subTotalPrice = 0;
    isApiCalled = false;

    shippingCharge = 0;
    totalAmount = 0;
    taxAmount = 0;
    promoAmount = 0;
    promoApplied = "";
    paymentMethod = "COD";
    couponId = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("ShoppingCartScreen shown");
    }
  }

  Future<List<ShoppingCartModel>> _handleFetchCart() async {
    double totalPrice = 0;
    List<ShoppingCartModel> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    if (user_id != null) {
      var requestParam = "?";
      requestParam += "user_id=" + user_id;
      print(user_id);
      final http.Response response = await http.get(
        Uri.parse(Consts.VIEW_CART + requestParam),
      );
      print(Consts.VIEW_CART + requestParam);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['status'];
        var productdataCount = responseData["productdata"];
        print(productdataCount);
        if (responseData['status'] == "success") {
          // print(mList);
          if (productdataCount.length > 0) {
            for (int i = 0; i < productdataCount.length; i++) {
              // List<String> galleryImages =[];
              var itemData = productdataCount[i];
              // print(itemData);
              ShoppingCartModel item = ShoppingCartModel();
              // var productDetails =itemData['productdata'];
              item.name = itemData['name'];
              item.product_id = itemData['product_id'];
              item.qty = itemData['qty'];
              item.row_id = itemData['row_id'];
              item.user_id = itemData['user_id'];
              item.price = itemData['price'];
              item.size = itemData['size'];
              item.product_image = itemData['product_image'];
              totalPrice += (double.parse(item.price) * int.parse(item.qty));

              mList.add(item);
            }
          }
        }

        setState(() {
          quentity = productdataCount.length.toString();
          _subTotalPrice = totalPrice;

          totalAmount = totalPrice + shippingCharge + taxAmount;
          if (mList.length > 0) {
            hasItemsInCart = true;
          } else {
            hasItemsInCart = false;
          }
          isApiCalled = true;
        });
        // print(quentity);
      } else {
        
      }

      return mList;
    } else {
      setState(() {
        isApiCalled = false;
        hasItemsInCart = false;
      });
    }
  }

  Future<List<AddressModel>> _getAddress() async {
    double totalPrice = 0;
    List<AddressModel> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    print(user_id);
    if (user_id != null) {
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
      debugPrint("Address Size ${defaultAddress.addressType}");
      return mList;
    } else {
      setState(() {
        isApiCalled = false;
        hasItemsInCart = false;
      });
    }
  }

  final double shapeHeight = 140;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, "refresh cart");
        // Navigator.pop(context);
        // if(mProductList.length > 0){
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        // }
        // else {
        //   Navigator.pop(context);
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => CategorytListScreen(),
        //     ),
        //   );
        // }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(),
        // drawer: Navigation(),
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
              child: !hasItemsInCart
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0XFFf9f7f7),
                                width: 4,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height - 200,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: 
                              isApiCalled
                                  ?
                                   Text("No items in cart")
                                  : CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // customShape(),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            defaultAddress != "null"
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 19.0,vertical: 6),
                                    child: Text(
                                      defaultAddress.addressType +
                                          "\n" +
                                          defaultAddress.city +
                                          "," +
                                          defaultAddress.country +
                                          "\n" +
                                          defaultAddress.state +
                                          "," +
                                          defaultAddress.landmark +
                                          "," +
                                          defaultAddress.pincode,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),

                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.amber[600],
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(9),
                              // ),
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 0.5,
                              // ),
                            ),
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllAdressScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Click add / Change Address',
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
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Container(
                                child: FutureBuilder(
                                  initialData: null,
                                  future: _productList,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      mProductList = snapshot.data;
                                      return ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: mProductList.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, int index) {
                                          ShoppingCartModel item =
                                              mProductList[index];
                                          return ItemShoppingCart(
                                            itemShopingCart: item,
                                            notifyParent: refresh,
                                            delItem: deleteItemFromList,
                                            itemIndex: index,
                                          );
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   height: 1,
                              //   color: Colors.black,
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 5),
                              //   child: Column(
                              //     // mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         "Offers",
                              //         style: TextStyle(
                              //           color: Color(0XFF232323),
                              //           fontSize: 22,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               // Icon(Icons.close,color: Colors.red,),
                              //               Image.asset(
                              //                 "images/cross1.png",
                              //                 fit: BoxFit.contain,
                              //               ),
                              //               Text(
                              //                 "Select a promo code",
                              //                 style: TextStyle(
                              //                   color: Color(0XFF232323),
                              //                   fontSize: 12,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Row(
                              //             children: [
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               InkWell(
                              //                 onTap: () {
                              //                   _applyPromo();
                              //                 },
                              //                 child: Text(
                              //                   // _offers,
                              //                   "View offers",
                              //                   style: TextStyle(
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w500,
                              //                     color: Color(0XFFD20014),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber[600],
                                    // borderRadius: BorderRadius.all(
                                    //   Radius.circular(9),
                                    // ),
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   width: 0.5,
                                    // ),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Upload Prepscription',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sub total",
                                      style: TextStyle(
                                        color: Color(0XFF232323),
                                        fontSize: 22,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\u20B9",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0XFFD20014),
                                          ),
                                        ),
                                        Text(
                                          "$_subTotalPrice",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0XFFD20014),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Shipping",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.shoppingCartDesctext,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\u20B9",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            // color: Color(0XFFD20014),
                                          ),
                                        ),
                                        Text(
                                          " $shippingCharge",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.shoppingCartDesctext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tax",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.shoppingCartDesctext,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\u20B9",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            // color: Color(0XFFD20014),
                                          ),
                                        ),
                                        Text(
                                          " $taxAmount",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.shoppingCartDesctext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              promoAmount == 0
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${promoApplied} is applied",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors
                                                  .shoppingCartDesctext,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "\u20B9",
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w700,
                                                  // color: Color(0XFFD20014),
                                                ),
                                              ),
                                              Text(
                                                " -$promoAmount",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors
                                                      .shoppingCartDesctext,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.shoppingCartDesctext,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\u20B9",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            // color: Color(0XFFD20014),
                                          ),
                                        ),
                                        Text(
                                          " $totalAmount",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                AppColors.shoppingCartDesctext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
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
                                              builder: (context) =>
                                                  CheckoutScreen(
                                                cartQuantity:
                                                    int.parse(quentity),
                                                couponId: couponId,
                                                shippingCost: shippingCharge,
                                                tax: taxAmount,
                                                totalAmpount: totalAmount,
                                                subTotalAmpount: _subTotalPrice,
                                                couponAmount: promoAmount,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Continue To Pay',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(9),
                                    ),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Continue Shopping',
                                          style: TextStyle(
                                            color: Color(0XFF050505),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomAppbar() {
    return AppBar(
      backgroundColor: AppColors.appBannerColor,
      toolbarHeight: 40,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context, "refresh cart");
            Navigator.pop(context);
            // Navigator.pop(context);
            FocusScope.of(context).unfocus();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(quentity: quentity),
              ),
            );
            // Navigator.pop(context);
          }),
      title: openSearch
          ? Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                controller: _searchController,
                autofocus: openSearch,
                onChanged: (value) => {
                  setState(
                    () {
                      _searchKey = value;
                    },
                  ),
                },
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFFbdc6cf),
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0XFFF8F8F8),
                  suffixIcon: IconButton(
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProductListScreen(
                    //         categoryID: "",
                    //         searchKeyword: _searchKey,
                    //       ),
                    //     ),
                    //   );
                    // },
                    icon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        debugPrint("Test");
                        setState(
                          () {
                            _searchKey = "";
                            _searchController.text = "";
                          },
                        );
                      },

                      // icon:Icons.clear,
                      // color: Colors.black,
                      // size: 12,
                    ),
                  ),
                  hintText: 'Search..',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                "Cart",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 19,
                ),
              ),
            ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.search,
        //     color: Colors.white,
        //     size: 35,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       openSearch = !openSearch;
        //     });
        //   },
        // )
      ],
    );
  }

  var userData = {};
  Future<Object> _checkUserIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String fname = prefs.getString("fname");
    String lname = prefs.getString("lname");
    if (email == null) return null;
    userData.putIfAbsent("userEmail", () => email);
    userData.putIfAbsent("userName", () => fname + ' ' + lname);

    return userData;
  }

  Widget customShape() {
    return ClipPath(
      // clipper: RedShape(MediaQuery.of(context).size.width, shapeHeight),
      child: Container(
        height: shapeHeight,
        decoration: BoxDecoration(
          color: Color(0XFFc80718),
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
                "Shopping Cart",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "$quentity Items",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  refresh() async {
    setState(() {});
    debugPrint("refresh called");
    _handleFetchCart();
  }

  deleteItemFromList(int index) async {
    setState(() {});
    debugPrint("deletedd $index called");

    mProductList.removeAt(index);
  }

  _applyPromo() async {
    // var result = await Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (BuildContext context) => ApplyPromoScreen(
    //       totalAmount: totalAmount,
    //     ),
    //     fullscreenDialog: true,
    //   ),
    // );

    // debugPrint("Returned data $result");

    // setState(() {
    //   promoAmount = result['discount'];
    //   promoApplied = result['promo_code'];
    //   couponId = result['promo_code_id'];
    //   paymentMethod = result['payment_method'];
    //   totalAmount = totalAmount - promoAmount;
    // });
  }
}
