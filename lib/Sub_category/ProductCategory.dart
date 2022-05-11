import 'dart:convert';

import 'package:burnett/Address/AddAddress.dart';
import 'package:burnett/Address/AddressModel.dart';
import 'package:burnett/Address/AllAdressScreen.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/Product_category/ProductModel.dart';
import 'package:burnett/checkout/CheckoutScreen.dart';
import 'package:burnett/shopping_cart/ShoppingCartModel.dart';
import 'package:burnett/shopping_cart/ShoppingCartScreen.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../shopping_cart/ItemShoppingCart.dart';
import '../util/AppColors.dart';
import '../util/Consts.dart';
import 'CategoryItem.dart';
import 'ProductModelCategory.dart';

class ProductCategory extends StatefulWidget {
  final ProductModel itemProduct;

  const ProductCategory({Key key, this.itemProduct}) : super(key: key);
  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  String _offers;
  bool hasItemsInCart;
  bool isApiCalled;
  Future<List<Category>> _productList;
  List<Category> mProductList;
  int quantity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offers = "Test";
    hasItemsInCart = false;
    mProductList = [];
    isApiCalled = false;
    _handleFetchCartquantity();
    quantity = 0;
    _productList = _handleFetchCart();
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

  Future<List<Category>> _handleFetchCart() async {
    double totalPrice = 0;
    List<Category> mList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    print(user_id);
    final http.Response response = await http.get(
      Uri.parse(Consts.CATEGORY_LIST + requestParam),
    );
    print(Consts.CATEGORY_LIST + requestParam);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverMessage = responseData['status'];
      var productdataCount = responseData["categorydata"];
      print(productdataCount);
      if (responseData['status'] == "success") {
        // print(mList);
        if (productdataCount.length > 0) {
          for (int i = 0; i < productdataCount.length; i++) {
            // List<String> galleryImages =[];
            var itemData = productdataCount[i];
            // print(itemData);
            Category item = Category();
            // var productDetails =itemData['productdata'];
            item.name = itemData['name'];
            item.catId = itemData['cat_id'];
            item.catPriority = itemData['cat_priority'];
            item.parentId = itemData['parent_id'];
            // item.price = itemData['price'];
            item.metaTitle = itemData['meta_title'];
            item.categoryImage = itemData['categoryimgstat'];

            mList.add(item);
          }
        }
      }

      setState(() {
        if (mList.length > 0) {
          hasItemsInCart = true;
        } else {
          hasItemsInCart = false;
        }
        isApiCalled = true;
      });
      // print(quentity);
    } else {}

    return mList;
  }

  Future<List<ShoppingCartModel>> _handleFetchCartquantity() async {
    double totalPrice = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
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
        appBar: AppBar(
          backgroundColor: AppColors.appBannerColor,
          toolbarHeight: 40,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                // Navigator.of(context).pop(),
                Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
          ),
          title: Center(
            child: Text(
              "Category",
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
                              child: isApiCalled
                                  ? Text("No items in cart")
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
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Image(
                                  image: AssetImage("images/top_img.png"),
                                  fit: BoxFit.cover,
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ],
                            ),
                            Container(
                              // color: Colors.blueAccent,
                              // height: 180,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              padding: new EdgeInsets.only(
                                top: 90 * .65,
                                right: 0.0,
                                left: 0.0,
                              ),
                              child: Image(
                                image: AssetImage("images/banner.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                                right: 18.0,
                                top: 270,
                                bottom: 20,
                              ),
                              child: Column(
                                children: [
                                  Container(
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
                                    child: FutureBuilder(
                                      initialData: null,
                                      future: _productList,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        // debugPrint(snapshot.data);
                                        if (snapshot.hasData) {
                                          mProductList = snapshot.data;
                                          return ListView.builder(
                                            padding: EdgeInsets.all(0),
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: mProductList.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, int index) {
                                              Category item =
                                                  mProductList[index];
                                              return CategoryItem(
                                                categorydata: item,
                                              );
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
}
