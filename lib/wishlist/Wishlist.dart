import 'dart:convert';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllWishlist.dart';
import 'WishListModel.dart';
import 'package:http/http.dart' as http;

class Wishlist extends StatefulWidget {
  // const Wishlist({Key key, this.itemProduct}) : super(key: key);
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  String _offers;
  bool hasItemsInCart;
  bool isApiCalled;
  Future<List<WishListModel>> _productList;
  List<WishListModel> mProductList;
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
    // _addressList = _getAddress();
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

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     print("ShoppingCartScreen shown");
  //   }
  // }

  Future<List<WishListModel>> _handleFetchCart() async {
    try {
      double totalPrice = 0;
      List<WishListModel> mList = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getString('user_id');
      var requestParam = "?";
      requestParam += "user_id=" + user_id;
      print(user_id);
      final http.Response response = await http.get(
        Uri.parse(Consts.USER_WISHLIST_PRODUCTS + requestParam),
      );
      print(Consts.USER_WISHLIST_PRODUCTS + requestParam);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['status'];
        var productdataCount = responseData["productdata"];
        print(productdataCount);
        if (serverMessage == "success") {
          print("serverMessage..." + serverMessage.toString());
          if (productdataCount.length > 0) {
            print("data...favourite items");
            for (int i = 0; i < productdataCount.length; i++) {
              // List<String> galleryImages =[];
              var itemData = productdataCount[i];
              // print(itemData);
              WishListModel item = WishListModel();
              var productDetails = itemData["productDetails"];
              item.productTitle = productDetails['product_title'];
              item.productId = itemData['product_id'];
              item.categoryId = productDetails['category_id'];
              item.productImage = itemData['productcatimg'];
              item.stockCount = productDetails['stock_count'];
              item.brandId = productDetails['brand_id'];

              mList.add(item);
            }
          }
        }

        setState(() {
          // quentity = productdataCount.length.toString();
          // _subTotalPrice = totalPrice;
          // totalAmount = totalPrice + shippingCharge + taxAmount;
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
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  final double shapeHeight = 140;

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () {
      //   Navigator.pop(context, "refresh cart");
      // },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(),
        // drawer: Navigation(),
        body: Container(
          //height: double.infinity,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: !isApiCalled
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  initialData: null,
                  future: _productList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("hasdata..." + snapshot.hasData.toString());
                      mProductList = snapshot.data;
                      print("MProductList..." + mProductList.toString());
                      return mProductList.length == 0
                          ? Center(child: Text("No Items Available"))
                          : ListView.builder(
                              itemCount: mProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                WishListModel item = mProductList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: AllWishlist(
                                    wishListModel: item,
                                    notifyParent: refresh,
                                    delItem: deleteItemFromList,
                                    itemIndex: index,
                                  ),
                                );
                              });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
          // child: !hasItemsInCart
          //     ?
          //     // Column(
          //     //     crossAxisAlignment: CrossAxisAlignment.center,
          //     //     children: [
          //     // SizedBox(
          //     //   height: 20,
          //     // ),
          //     // Padding(
          //     //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     // child: Container(
          //     //   decoration: BoxDecoration(
          //     //     color: Color(0xFFFFFFFF),
          //     //     borderRadius: BorderRadius.circular(15),
          //     //     border: Border.all(
          //     //       color: Color(0XFFf9f7f7),
          //     //       width: 4,
          //     //     ),
          //     //   ),
          //     // height: MediaQuery.of(context).size.height - 200,
          //     // width: MediaQuery.of(context).size.width,
          //     Center(
          //         child: isApiCalled
          //             ? Text("No items in cart")
          //             : CircularProgressIndicator(),
          //       )
          //     //),
          //     //),
          //     //],
          //     //)
          //     :
          //     // Column(
          //     //     crossAxisAlignment: CrossAxisAlignment.start,
          //     // children: [
          //     //   // customShape(),
          //     //   // SizedBox(
          //     //   //   height: 20,
          //     //   // ),

          //     //   Padding(
          //     //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     //     child: Column(
          //     //       children: [
          //     Expanded(
          //         child: FutureBuilder(
          //           initialData: null,
          //           future: _productList,
          //           builder: (BuildContext context, AsyncSnapshot snapshot) {
          //             if (snapshot.hasData) {
          //               print("hasdata..." + snapshot.hasData.toString());
          //               mProductList = snapshot.data;
          //               print("MProductList..." + mProductList.toString());
          //               return ListView.builder(
          //                 padding: EdgeInsets.all(0),
          //                 shrinkWrap: true,
          //                 //physics: NeverScrollableScrollPhysics(),
          //                 itemCount: mProductList.length,
          //                 scrollDirection: Axis.vertical,
          //                 itemBuilder: (context, int index) {
          //                   WishListModel item = mProductList[index];
          //                   print("Item..." + item.toString());
          //                   return Padding(
          //                     padding:
          //                         const EdgeInsets.symmetric(vertical: 12.0),
          //                     child: AllWishlist(
          //                       wishListModel: item,
          //                       notifyParent: refresh,
          //                       delItem: deleteItemFromList,
          //                       itemIndex: index,
          //                     ),
          //                   );
          //                 },
          //               );
          //             } else {
          //               return Container();
          //             }
          //           },
          //         ),
          //       ),
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomePage(),
            //   ),
            // );
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
                "Favourites Items",
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

  refresh() async {
    //setState(() {});
    debugPrint("refresh called");
    // _handleFetchCart();
  }

  deleteItemFromList(int index) async {
    setState(() {});
    debugPrint("deletedd $index called");

    mProductList.removeAt(index);
  }
}
