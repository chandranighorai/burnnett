import 'dart:convert';

import 'package:burnett/Home/ProductDataModel.dart';
import 'package:burnett/Home/Search.dart';
import 'package:burnett/navigation_drawer/Navigation.dart';
import 'package:burnett/shopping_cart/ShoppingCartModel.dart';
import 'package:burnett/shopping_cart/ShoppingCartScreen.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CategoryItem.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final quentity;
  const HomePage({
    Key key,
    this.quentity,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ProductDataModel> _arrCategories;
  String _searchKey = "";
  int quentity = 0;
  bool openSearch;
  var _searchController = new TextEditingController();

  Future<ProductDataModel> _getCategories() async {
    var url = Uri.parse(Consts.PRODUCT_LIST);
    debugPrint("url in productList...$url");
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverMessage = responseData['message'];
      if (responseData['status'] == "success") {
        // debugPrint("$responseData");
        return ProductDataModel.fromJson(responseData);
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      showCustomToast("Error while conneting to server");
      throw Exception("Error getting response  ${response.statusCode}");
    }
    return null;
  }

  Future<List<ShoppingCartModel>> _handleFetchCart() async {
    double totalPrice = 0;
    List<ShoppingCartModel> mList = [];
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
            quentity = productdataCount.length;
          });
        } else {
          setState(() {
            quentity = 0;
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

    _arrCategories = _getCategories();
    _handleFetchCart();
    // debugPrint("$_arrCategories");
    _searchKey = "";
    openSearch = false;
  }

  @override
  void dispose() {
    _searchController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(_arrCategories);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Container(alignment: Alignment.topLeft, child: Navigation()),
      appBar: AppBar(backgroundColor: AppColors.appBannerColor, elevation: 0,
          // title: openSearch
          //     ? Theme(
          //         data: Theme.of(context)
          //             .copyWith(splashColor: Colors.transparent),
          //         child: TextField(
          //           controller: _searchController,
          //           autofocus: openSearch,
          //           onChanged: (value) => {
          //             setState(
          //               () {
          //                 _searchKey = value;
          //               },
          //             ),
          //           },
          //           style: TextStyle(
          //             fontSize: 14.0,
          //             color: Color(0xff000000),
          //           ),
          //           keyboardType: TextInputType.text,
          //           decoration: InputDecoration(
          //             filled: true,
          //             fillColor: Color(0XFFF8F8F8),
          //             suffixIcon: IconButton(
          //               onPressed: () {
          //                 // Navigator.push(
          //                 //   context,
          //                 //   MaterialPageRoute(
          //                 //     builder: (context) => ProductListScreen(
          //                 //       categoryID: "",
          //                 //       searchKeyword: _searchKey,
          //                 //     ),
          //                 //   ),
          //                 // );
          //               },
          //               icon: IconButton(
          //                 icon: Icon(
          //                   Icons.clear,
          //                   color: Colors.black,
          //                   size: 20,
          //                 ),
          //                 onPressed: () {
          //                   debugPrint("Test");
          //                   setState(
          //                     () {
          //                       _searchKey = "";
          //                       _searchController.text = "";
          //                     },
          //                   );
          //                 },

          //                 // icon:Icons.clear,
          //                 // color: Colors.black,
          //                 // size: 12,
          //               ),
          //             ),
          //             hintText: 'Search..',
          //             hintStyle: TextStyle(
          //               color: Colors.black,
          //             ),
          //             contentPadding: EdgeInsets.all(10.0),
          //             focusedBorder: OutlineInputBorder(
          //               borderSide: BorderSide(color: Colors.white),
          //               borderRadius: BorderRadius.circular(4),
          //             ),
          //             enabledBorder: UnderlineInputBorder(
          //               borderSide: BorderSide(color: Colors.white),
          //               borderRadius: BorderRadius.circular(4),
          //             ),
          //           ),
          //         ),
          //       )
          //     : Center(
          //         // child: Text(
          //         //   "Vedic",
          //         //   style: TextStyle(
          //         //     fontFamily: "Philosopher",
          //         //     fontSize: 36,
          //         //   ),
          //         // ),
          //         ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Search()));
                    // debugPrint("Search Pressed");
                    // if (openSearch &&
                    //     _searchKey != null &&
                    //     _searchKey.isNotEmpty) {
                    //   // Navigator.push(
                    //   // context,
                    //   // MaterialPageRoute(
                    //   //   builder: (context) => ProductListScreen(
                    //   //     searchKeyword: _searchKey,
                    //   //     categoryID: "",
                    //   //     categoryName: "",
                    //   //   ),
                    //   // ),
                    //   // );
                    //   setState(() {
                    //     openSearch = !openSearch;
                    //   });
                    // } else {
                    //   setState(() {
                    //     openSearch = !openSearch;
                    //   });
                    // }
                  },
                ),
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
                                    "$quentity",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [],
            )
          ]),
      body: SafeArea(
        child: Container(
          //height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/login_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            //physics: ScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/top_img.png"),
                      fit: BoxFit.cover,
                      height: 140,
                      width: MediaQuery.of(context).size.width,
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
                        right: 8.0,
                        top: 270,
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //height: MediaQuery.of(context).size.height - 360,
                            decoration: BoxDecoration(
                              // border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(9),
                              // color: Color(0xFFFFFFFF),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey,
                              //     offset: Offset.zero,
                              //     blurRadius: 6.0,
                              //     spreadRadius: 0.0,
                              //   ),
                              // ],
                            ),
                            child: FutureBuilder(
                                initialData: null,
                                future: _arrCategories,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  // debugPrint(snapshot.data);
                                  if (snapshot.hasData) {
                                    var categories = snapshot.data.productdata;
                                    return GridView.builder(
                                        itemCount: categories.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 2.0,
                                                mainAxisSpacing: 8.0),
                                        itemBuilder: (context, int index) {
                                          Productdata productData =
                                              categories[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: CategoryItem(
                                              productdata: productData,
                                            ),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                          // CategoryList(arrCategories: _arrCategories),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }

  // NavDrawer(){
  //   new Widget(
  //
  //   );
  // }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
    @required Future<ProductDataModel> arrCategories,
  })  : _arrCategories = arrCategories,
        super(key: key);

  final Future<ProductDataModel> _arrCategories;
// debugPrint(_arrCategories);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 360,
          child: FutureBuilder(
              initialData: null,
              future: _arrCategories,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // debugPrint(snapshot.data);
                if (snapshot.hasData) {
                  var categories = snapshot.data.productdata;
                  return GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (context, int index) {
                        Productdata productData = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CategoryItem(
                            productdata: productData,
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
