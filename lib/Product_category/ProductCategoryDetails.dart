import 'dart:convert';

import 'package:burnett/shopping_cart/ShoppingCartModel.dart';
import 'package:burnett/shopping_cart/ShoppingCartScreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util/AppColors.dart';
import '../util/Consts.dart';
import 'CategoryAlpha.dart';
import 'CategoryItemAlpha.dart';
import 'CategoryItemDetails.dart';
import 'ProductModelCategory.dart';
import 'ProductbycategoryDetails.dart';

class ProductCategoryDetails extends StatefulWidget {
  // final ProductbycategoryDetails productbycategoryDetails;
  final categoryID;
  const ProductCategoryDetails({Key key, this.categoryID}) : super(key: key);
  @override
  _ProductCategoryDetailsState createState() => _ProductCategoryDetailsState();
}

class _ProductCategoryDetailsState extends State<ProductCategoryDetails> {
  String _offers;
  bool hasItemsInCart;
  bool isApiCalled;
  Future<ProductbycategoryDets> _productList;
  // List<ProductbycategoryDets> mProductList;
  List<CategoryAlpha> _mAlphaList;
  Future<List<CategoryAlpha>> _mAlphabet;
  String alphabe = "";
  int quantity;
  var mAlphabeta = [
    'All',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offers = "Test";
    hasItemsInCart = false;
    // mProductList = [];
    isApiCalled = true;
    _mAlphaList = [];
    _productList = _handleFetchCategory();
    _mAlphabet = _handleFetchAlpha();
    quantity = 0;
    _handleFetchCartquantity();
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

  Future<ProductbycategoryDets> _handleFetchCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');

    if (alphabe == "") {
      var requestParam = "?";
      requestParam += "cat_id=" + widget.categoryID;
      print(user_id);
      final http.Response response = await http.get(
        Uri.parse(Consts.productlist_by_category + requestParam),
      );
      print(Consts.productlist_by_category + requestParam);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData);
        if (responseData['status'] == "success") {
          setState(() {
            hasItemsInCart = true;
            isApiCalled = true;
          });
          return ProductbycategoryDets.fromJson(responseData);
        } else {
          setState(() {
            hasItemsInCart = false;
            isApiCalled = false;
          });
        }
      } else {}
    } else {
      var requestParam = "?";
      requestParam += "key=" + alphabe;
      print(user_id);
      final http.Response response = await http.get(
        Uri.parse(Consts.productlist_by_keyword + requestParam),
      );
      print(Consts.productlist_by_keyword + requestParam);
      setState(() {
        hasItemsInCart = false;
        isApiCalled = true;
      });
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == "success") {
          setState(() {
            hasItemsInCart = true;
            isApiCalled = true;
          });

          return ProductbycategoryDets.fromJson(responseData);
        } else {
          setState(() {
            hasItemsInCart = false;
            isApiCalled = true;
          });
        }
      } else {}
    }
    return null;
  }

  Future<ProductbycategoryDets> _handleFetchCategoryAlpha(String alpha) async {
    double totalPrice = 0;
    // List<ProductbycategoryDets> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "key=" + alpha;
    print(user_id);
    final http.Response response = await http.get(
      Uri.parse(Consts.productlist_by_keyword + requestParam),
    );
    print(Consts.productlist_by_keyword + requestParam);
    setState(() {
      hasItemsInCart = false;
      isApiCalled = true;
    });
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // var serverMessage = responseData['status'];
      // var productdataCount = responseData["productdata"];
      // print(responseData);
      // print(productdataCount);
      if (responseData['status'] == "success") {
        // print(responseData);
        setState(() {
          // if (mList.length > 0) {
          hasItemsInCart = true;
          // } else {
          // hasItemsInCart = false;
          // }
          isApiCalled = true;
        });
        return ProductbycategoryDets.fromJson(responseData);
      } else {
        setState(() {
          hasItemsInCart = false;
          isApiCalled = true;
        });
      }
      // }

    } else {}

    return null;
  }

  Future<List<CategoryAlpha>> _handleFetchAlpha() async {
    double totalPrice = 0;
    List<CategoryAlpha> mList = [];

    for (int i = 0; i < mAlphabeta.length; i++) {
      CategoryAlpha item = CategoryAlpha();
      item.alphKey = mAlphabeta[i];

      mList.add(item);
    }

    // setState(() {
    //   if (mList.length > 0) {
    //     hasItemsInCart = true;
    //   } else {
    //     hasItemsInCart = false;
    //   }
    //   isApiCalled = true;
    // });
    // print(quentity);
    // } else {}
    CategoryAlpha itemas = mList[0];
    print(itemas.alphKey);
    return mList;
  }

  Future<List<ShoppingCartModel>> _handleFetchCartquantity() async {
    double totalPrice = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
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
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.appBannerColor,
          toolbarHeight: 40,
          elevation: 0,
          title: Center(
            child: Text(
              "Medicine",
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
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
            ),
          ],
        ),
        // drawer: Navigation(),
        body: SafeArea(
          child: Container(
            //height: double.infinity,
            height: MediaQuery.of(context).size.height,
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
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: !isApiCalled
                                  ? Text("No items in category")
                                  : CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: <Widget>[
                            // customShape(),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.04,
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02,
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.white),
                                // color: Colors.amberAccent,
                                child: FutureBuilder(
                                    initialData: null,
                                    future: _mAlphabet,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      // debugPrint(snapshot.data);
                                      if (snapshot.hasData) {
                                        _mAlphaList = snapshot.data;
                                        return ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          // shrinkWrap: true,
                                          // physics:
                                          //     NeverScrollableScrollPhysics(),
                                          itemCount: _mAlphaList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, int index) {
                                            CategoryAlpha item =
                                                _mAlphaList[index];
                                            return CategoryItemAlpha(
                                              categorydata: item,
                                              notifyParent: refresh,
                                              sortItem: alphaItemFromList,
                                              // itemIndex: index,
                                            );
                                          },
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                                right: 18.0,
                                top: 70,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        120,
                                    child: FutureBuilder(
                                      initialData: null,
                                      future: _productList,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        // debugPrint(snapshot.data);
                                        if (snapshot.hasData) {
                                          var mProductList =
                                              snapshot.data.productdata;
                                          return ListView.builder(
                                            //padding: EdgeInsets.all(0),
                                            itemCount: mProductList.length,
                                            shrinkWrap: true,
                                            // physics:
                                            //     NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, int index) {
                                              Productdata item =
                                                  mProductList[index];
                                              print(
                                                  "item..." + item.toString());
                                              return CategoryItemDetails(
                                                  categorydata: item,
                                                  item: item.productAttribute);
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  refresh() async {
    setState(() {});
    debugPrint("refresh called");
    // _handleFetchCart();
  }

  alphaItemFromList(String alphab) async {
    setState(() {});
    debugPrint("deletedd $alphab called");

    setState(
      () {
        alphabe = alphab;
      },
    );
    _handleFetchCategory();
    // _handleFetchCategoryAlpha(alphab);
    // mProductList.removeAt(index);
  }
}
