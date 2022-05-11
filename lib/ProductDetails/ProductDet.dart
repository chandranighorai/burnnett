import 'dart:convert';

import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/ProductDetails/RelatedProduct.dart';
import 'package:burnett/ProductDetails/ViewAllReviews.dart';
import 'package:burnett/ProductDetails/WriteReview.dart';
import 'package:burnett/login/LoginScreen.dart';
import 'package:burnett/shopping_cart/ShoppingCartModel.dart';
import 'package:burnett/shopping_cart/ShoppingCartScreen.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_share/flutter_share.dart';

import 'ProductModel.dart';
import 'package:http/http.dart' as http;

class ProductDet extends StatefulWidget {
  final String searchKeyword;
  final String categoryID;
  final String categoryName;
  final String seleType;
  final bool isSelect;
  final double selectPrice;
  const ProductDet({
    Key key,
    this.searchKeyword,
    this.categoryID,
    this.categoryName,
    this.seleType,
    this.isSelect,
    this.selectPrice,
  }) : super(key: key);
  @override
  _ProductDetState createState() => _ProductDetState();
}

class _ProductDetState extends State<ProductDet> {
  String _pageTitle;
  Future<ProductDetailsModel> _productList;
  // Future<List<WishListModel>> _productwishList;
  String _chosenValue;
  List menuitems = [
    'Select user type',
    'User',
    'Doctor',
    'Distributor',
    'Stockist'
  ];
  int _itemCount = 1;
  bool _callingUpdateApi = false;
  String product_id;
  bool _showLoder;
  double containerWidth = 70;
  bool wish;
  double selectPrice;
  double demoPrice;
  double addPrice = 0;
  String selectpType;
  String seleType;
  bool isadd;
  bool isCart;
  bool isPrice, isSelect;
  bool _isAddedToCart;
  SharedPreferences prefs;
  int quantity;
  int rowId;
  var user_id, user_name, user_email;
  // String action;

  Future<ProductDetailsModel> _getProductdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString("user_id");
    var fName = prefs.getString("fname");
    var lName = prefs.getString("lname");
    user_name = fName + " " + lName;
    user_email = prefs.getString("email");
    var resoponse = "?";
    resoponse += "product_id=" + product_id;
    print("response in product details..." + resoponse.toString());
    var url = Uri.parse(Consts.PRODUCT_DETAILS + resoponse);
    print("url" + url.toString());
    var response = await http.get(
      url,
    );
    print("response body..." + response.body);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData['status']);
      var attribute;
      var serverMessage = responseData['message'];
      if (responseData['status'] == "success") {
        _showLoder = false;
        _itemCount = 1;
        // if (responseData['status']== "success") {
        //  attribute = responseData['productdata'];
        //   // seleType=attribute['product_attribute'];
        //   print(attribute);
        // } else {
        //   seleType = "";
        // }
        _handleFetchCart();
        return ProductDetailsModel.fromJson(responseData);
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      showCustomToast("Error while conneting to server");
      throw Exception("Error getting response  ${response.statusCode}");
    }

    return null;
  }

  Future<List<ShoppingCartModel>> _handleFetchCartquantity() async {
    double totalPrice = 0;
    List<ShoppingCartModel> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
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
          setState(() {
            quantity = productdataCount.length;
          });
        } else {
          setState(() {
            quantity = 0;
          });
        }
      }
      // print(quentity);
    } else {}

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showLoder = true;
    _isAddedToCart = false;
    product_id = widget.categoryID;
    if (widget.seleType == null) {
      isSelect = false;
    } else {
      seleType = widget.seleType;
      isSelect = widget.isSelect;
      selectPrice = widget.selectPrice;
    }

    // print(seleType);
    isPrice = true;
    quantity = 0;
    isCart = false;

    _productList = _getProductdetails();
    _handleFetchCartquantity();
    // Productdata productdata=_productList.productdata;
  }

  @override
  Widget build(BuildContext context) {
    print("prodictId...product_id..." + product_id.toString());
    print("prodictId...seleType..." + seleType.toString());
    print("prodictId...isSelect..." + isSelect.toString());
    print("prodictId...selectPrice...." + selectPrice.toString());
    print("prodictId...isPrice...." + isPrice.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBannerColor,
        toolbarHeight: 40,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(quentity: quantity),
            ),
          ),
        ),
        title: Center(
          child: Text(
            widget.categoryName,
          ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCartScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 40,
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.card_travel,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appBannerColor,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "$quantity",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
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
          child: FutureBuilder(
              initialData: null,
              future: _productList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var categories = snapshot.data.productdata;
                  print("Categories..." + categories.toString());
                  Productdata productDetailsModel = categories[0];
                  //  ProductReview productReview =
                  //       productDetailsModel.productReview[
                  //           productDetailsModel.productReview.length - 1];
                  //   print("productReview..." + productReview.message);
                  print("prodctDetailsModel..." +
                      productDetailsModel.productType.toString());
                  if (productDetailsModel.productType == "simple") {
                    if (isPrice == true) {
                      selectPrice = double.parse(
                          productDetailsModel.productPrice.toString());
                      demoPrice = double.parse(
                          productDetailsModel.productPrice.toString());
                    } else {}
                    // demoPrice
                  } else {
                    print("IsSeclect..." + isSelect.toString());
                    print("IsSeclect...0..." + isPrice.toString());

                    if (!isSelect) {
                      if (isPrice == true) {
                        selectPrice = double.parse(productDetailsModel
                            .productAttribute[0].productPrice
                            .toString());
                        print("IsSelect...3..." +
                            productDetailsModel.productAttribute.isEmpty
                                .toString());
                        print("IsSeclect...1..." + selectPrice.toString());
                        demoPrice = double.parse(productDetailsModel
                            .productAttribute[0].productPrice
                            .toString());
                        print("IsSeclect...2..." + demoPrice.toString());
                        seleType = productDetailsModel.productAttribute[0].name
                            .toString();
                        print("IsSeclect...3..." + seleType.toString());

                        print("IsSeclect...3..." +
                            productDetailsModel.productcatimg.toString());

                        isadd = true;
                      } else {}
                    } else {}
                    // demoPrice
                  }

                  //print(productDetailsModel.metaTitle);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1),
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
                                  height: 180,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Image.network(
                                    productDetailsModel.productcatimg,
                                    height: containerWidth,
                                    //width: 100,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Container();
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
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
                                                  new AlwaysStoppedAnimation<
                                                      Color>(
                                                Colors.grey,
                                              ),
                                              strokeWidth: 2,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width / 3.4,
                                decoration: BoxDecoration(
                                  // border: Border.all(width: 1),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Wishlist"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          // wish
                                          // ?
                                          InkWell(
                                        onTap: (() => _handleAddWish(
                                            productDetailsModel, "add")),
                                        child: Image(
                                          image: AssetImage(
                                              "images/ic_wishlist.png"),
                                        ),
                                      ),
                                      // : InkWell(
                                      //     onTap: (() =>_handleAddWish(productDetailsModel,"remove")),
                                      //     child: Image(
                                      //       image: AssetImage(
                                      //           "images/ic_wishlistActive.png"),
                                      //     ),
                                      // ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WriteReview(
                                                  productId: productDetailsModel
                                                      .uniqueKey,
                                                  userId: user_id,
                                                  userName: user_name,
                                                  userEmail: user_email)))
                                      .then((value) {
                                    setState(() {
                                      _productList = _getProductdetails();
                                    });
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  // width: 100,
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1),
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
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Write a review"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _share(productDetailsModel.shareUrl,
                                      productDetailsModel.productTitle);
                                },
                                child: Container(
                                  height: 30,
                                  // width: 100,
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,

                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Share"),
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: Colors.red,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        productDetailsModel.productAttribute.isEmpty
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: Container(
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            canvasColor: Colors.white,
                                          ),
                                          child: new DropdownButton<String>(
                                            hint: new Text(
                                              "Select unit",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            value: seleType,
                                            // isDense: true,
                                            isExpanded: true,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectpType = newValue;
                                                seleType = newValue;
                                                selectPrice = 0.0;
                                                _itemCount = 1;
                                                isPrice = false;
                                              });
                                              productDetailsModel
                                                  .productAttribute
                                                  .map((ProductAttribute map) {
                                                if (map.name == newValue) {
                                                  setState(() {
                                                    selectPrice = double.parse(
                                                        map.productPrice
                                                            .toString());
                                                    demoPrice = double.parse(map
                                                        .productPrice
                                                        .toString());
                                                  });
                                                  _handleFetchCart();
                                                  if (isadd) {
                                                    setState(() {
                                                      seleType = newValue;
                                                    });
                                                  } else {}
                                                }
                                                print(map.name +
                                                    " " +
                                                    selectpType +
                                                    " " +
                                                    selectPrice.toString());
                                              }).toList();
                                            },
                                            // style: ,
                                            icon: Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: Colors.black,
                                              size: 40,
                                            ),
                                            items: productDetailsModel
                                                .productAttribute
                                                .map((ProductAttribute map) {
                                              return new DropdownMenuItem<
                                                  String>(
                                                value: map.name,
                                                child: new Text(
                                                  map.name,
                                                  style: new TextStyle(
                                                      color: Colors.black),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // productDetailsModel.productType == "variable"
                                  // ?
                                  Text(
                                    "\u20B9 ${selectPrice.toString()}",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0XFFD20014),
                                    ),
                                  )
                                  // : Text(
                                  //     "\u20B9 ${productDetailsModel.productPrice}",
                                  //     style: TextStyle(
                                  //       fontSize: 26,
                                  //       fontWeight: FontWeight.w700,
                                  //       color: Color(0XFFD20014),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Quentity",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFF0D0D0D),
                                  ),
                                ),
                                // TextButton(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      'images/ic_minus.png'),
                                                  onPressed: () {
                                                    DcrBtn(demoPrice,
                                                        productDetailsModel);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width: 20,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  _itemCount.toString(),
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .categoryTextColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                child: IconButton(
                                                  icon: Image.asset(
                                                      'images/ic_plus.png'),
                                                  onPressed: () {
                                                    IncrBtn(demoPrice,
                                                        productDetailsModel);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          _callingUpdateApi
                                              ? Center(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      top: 15,
                                                    ),
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.blueGrey),
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                  // border: Border.all(width: 1),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0XFF474747),
                                        ),
                                      ),
                                      Text(productDetailsModel
                                          .productDescription),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        productDetailsModel.productReview.length == 0
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Reviews",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0XFF474747),
                                    ),
                                  ),
                                ),
                              ),
                        productDetailsModel.productReview.length == 0
                            ? SizedBox()
                            : SizedBox(
                                height: 10,
                              ),
                        productDetailsModel.productReview.length == 0
                            ? SizedBox()
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 1),
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
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // RatingBar.builder(
                                            //   initialRating: 5,
                                            //   minRating: 1,
                                            //   direction: Axis.horizontal,
                                            //   allowHalfRating: true,
                                            //   itemCount: 5,
                                            //   itemSize: 20,
                                            //   unratedColor: Colors.grey,
                                            //   //glowColor: Colors.red,
                                            //   itemPadding: EdgeInsets.symmetric(
                                            //       horizontal: 4.0),
                                            //   itemBuilder: (context, _) => Icon(
                                            //     Icons.star,
                                            //     color: Colors.amber,
                                            //   ),
                                            //   onRatingUpdate: (rating) {
                                            //     print(rating);
                                            //   },
                                            // ),
                                            Text(
                                              productDetailsModel
                                                  .productReview[
                                                      productDetailsModel
                                                              .productReview
                                                              .length -
                                                          1]
                                                  .message,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.045,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0XFF474747),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              productDetailsModel
                                                  .productReview[
                                                      productDetailsModel
                                                              .productReview
                                                              .length -
                                                          1]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF474747),
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            Text(
                                              productDetailsModel
                                                  .productReview[
                                                      productDetailsModel
                                                              .productReview
                                                              .length -
                                                          1]
                                                  .dateAdded,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF474747),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            productDetailsModel
                                                        .productReview.length <
                                                    2
                                                ? SizedBox()
                                                : Center(
                                                    child: TextButton(
                                                      child: Text(
                                                        "View All Reviews",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () =>
                                                          reviewsClick(
                                                              productDetailsModel
                                                                  .productReview),
                                                    ),
                                                  ),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            // Text("Description"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        productDetailsModel.relatedProductList.length == 0
                            ? SizedBox()
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    child: Text(
                                      "Similar Products",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0XFF474747),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        productDetailsModel.relatedProductList.length == 0
                            ? SizedBox()
                            : SizedBox(
                                height: 20,
                              ),
                        productDetailsModel.relatedProductList.length == 0
                            ? SizedBox()
                            : Container(
                                height: 200,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: productDetailsModel
                                        .relatedProductList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      RelatedProductList relatedData =
                                          productDetailsModel
                                              .relatedProductList[index];
                                      return RelatedProduct(
                                          relatedData: relatedData,
                                          baseUrl: productDetailsModel.baseUrl);
                                    }),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              // alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 30,
                              height: 50,
                              child: !_isAddedToCart
                                  ? TextButton(
                                      onPressed: () {
                                        _handleAddCart(productDetailsModel);
                                        //;
                                      },
                                      child: Text(
                                        'Add to cart'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShoppingCartScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Go to cart'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                } else {
                  return _showLoder
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: Column(
                            children: [Text("")],
                          ),
                        );
                }
              }),
        ),
      ),
    );
  }

  Future<Null> _handleAddCart(Productdata itemProduct) async {
    prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    print(user_id);
    if (user_id == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&product_id=" + itemProduct.productId;
    requestParam += "&name=" + itemProduct.productTitle.trim();
    requestParam += "&price=" + demoPrice.toString();
    requestParam += "&quantity=" + _itemCount.toString();
    requestParam += "&size=" + seleType.toString();
    final http.Response response = await http.get(
      Uri.parse(Consts.ADD_CART + requestParam),
    );
    print(Consts.ADD_CART + requestParam);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverCode = responseData['code'];
      if (serverCode == "200") {
        setState(() {
          _isAddedToCart = true;
          quantity += 1;
          rowId = int.parse(responseData['row_id'].toString());
        });
      }
      _handleFetchCartquantity();
      var serverMessage = responseData['message'];
      showCustomToast(serverMessage);
    } else {}
  }

  Future<Null> _handleAddWish(Productdata itemProduct, String action) async {
    prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    print(user_id);
    if (user_id == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&product_id=" + itemProduct.productId;
    requestParam += "&action=" + action;
    final http.Response response = await http.get(
      Uri.parse(Consts.ADD_TO_WISHLIST + requestParam),
    );
    // print(Consts.ADD_CART + requestParam);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverCode = responseData['code'];
      if (serverCode == "200") {
        setState(() {
          _isAddedToCart = true;
        });
      }

      var serverMessage = responseData['message'];
      showCustomToast(serverMessage);
    } else {}
  }

  Future<Null> _handleFetchCart() async {
    prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    if (!user_id.isEmpty) {
      requestParam += "user_id=" + user_id;
      print(requestParam);
      final http.Response response = await http.get(
        Uri.parse(Consts.VIEW_CART + requestParam),
      );
      // print(Consts.VIEW_CART + requestParam);
      // print(response.body);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverCode = responseData['code'];
        var serverMessage = responseData['message'];
        if (serverCode == "200") {
          var arrCartProducts = responseData["productdata"];
          if (arrCartProducts.length > 0) {
            for (int i = 0; i < arrCartProducts.length; i++) {
              print(seleType);
              print(product_id == arrCartProducts[i]['product_id'].toString() &&
                  seleType == arrCartProducts[i]['size']);
              if (seleType == null) {
                if (product_id == arrCartProducts[i]['product_id'].toString()) {
                  setState(() {
                    _isAddedToCart = true;
                    rowId = int.parse(arrCartProducts[i]['row_id'].toString());
                    _itemCount =
                        int.parse(arrCartProducts[i]['qty'].toString());

                    selectPrice =
                        double.parse(arrCartProducts[i]['price'].toString()) *
                            _itemCount;
                    isPrice = false;
                    isCart = true;
                  });
                  break;
                } else {
                  setState(() {
                    _isAddedToCart = false;
                  });
                }
              } else {
                if (product_id == arrCartProducts[i]['product_id'].toString() &&
                    seleType == arrCartProducts[i]['size']) {
                  setState(() {
                    _isAddedToCart = true;
                    rowId = int.parse(arrCartProducts[i]['row_id'].toString());
                    _itemCount =
                        int.parse(arrCartProducts[i]['qty'].toString());

                    selectPrice =
                        double.parse(arrCartProducts[i]['price'].toString()) *
                            _itemCount;
                    isPrice = false;
                    isCart = true;
                  });
                  print(arrCartProducts[i]['price'].toString());
                  break;
                } else {
                  setState(() {
                    _isAddedToCart = false;
                  });
                }
              }
            }
            setState(() {
              quantity = arrCartProducts.length;
            });
          }
        } else {
          print("Else part");
          setState(() {
            quantity = 0;
            _itemCount = 1;
            _isAddedToCart = false;
            selectPrice = double.parse(demoPrice.toString()) * _itemCount;
            _callingUpdateApi = false;
          });
        }
      }
    } else {
      setState(() {});
    }
  }

  _updateCart(String productId, int quantity) async {
    setState(() {
      _callingUpdateApi = true;
    });
    var requestParam = "?";
    requestParam += "row_id=" + rowId.toString();
    requestParam += "&quantity=" + quantity.toString();
    final http.Response response = await http.get(
      Uri.parse(Consts.UPDATE_CART + requestParam),
    );
    print(Consts.UPDATE_CART + requestParam);
    if (response.statusCode == 200) {
      setState(() {
        _callingUpdateApi = false;
      });
      var responseData = jsonDecode(response.body);
      var serverCode = responseData['code'];
      _handleFetchCartquantity();
      if (serverCode == "200") {}

      var serverMessage = responseData['message'];
      showCustomToast(serverMessage);
    } else {}
  }

  IncrBtn(double product_price, Productdata itemProduct) {
    // setState(() => _itemCount++);
    // priceCart=price*_itemCount;
    setState(() {
      _itemCount++;
      selectPrice = (double.parse(product_price.toString()) * _itemCount);
      isPrice = false;
      // 99.00;
    });
    print(selectPrice);
    if (_isAddedToCart) {
      _updateCart(itemProduct.productId, _itemCount);
    } else {
      _handleAddCart(itemProduct);
    }
  }

  DcrBtn(double product_price, Productdata itemProduct) {
    setState(() {
      _itemCount <= 1 ? _itemCount = 1 : _itemCount--;
      selectPrice = double.parse(product_price.toString()) * _itemCount;
    });
    if (_isAddedToCart) {
      _updateCart(itemProduct.productId, _itemCount);
    } else if (_itemCount >= 1) {
      _handleAddCart(itemProduct);
      // }
    }
  }

  reviewsClick(List<ProductReview> reviewList) {
    print("review..." + reviewList.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewAllReviews(reviewList: reviewList)));
  }

  _share(String url, String title) async {
    print("URL..." + url.toString());
    await FlutterShare.share(title: title, linkUrl: url);
  }
}
