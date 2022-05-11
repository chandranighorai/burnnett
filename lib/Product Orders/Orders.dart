import 'dart:convert';

import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/Product%20Orders/OrdersItem.dart';
import 'package:burnett/navigation_drawer/Navigation.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OrderDetails.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future<OrderDetails> _arrCategories;
  String _searchKey = "";
  bool openSearch;
  var _searchController = new TextEditingController();

  final double shapeheight = 200;
  //
  // Future<CategoryModel> _arrCategories;
  // String _searchKey = "";
  // bool openSearch;
  // var _searchController = new TextEditingController();
  //
  // final double shapeheight = 200;

  Future<OrderDetails> _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?user_id=" + user_id;
    // var url = Uri.parse(Consts.getAllOrders+requestParam);
    // debugPrint("$url");
    // var response = await http.get(
    //   url,
    // );
    final http.Response response = await http.get(
      Uri.parse(Consts.getAllOrders + requestParam),
    );
    debugPrint("${Uri.parse(Consts.getAllOrders + requestParam)}");
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // print(responseData);

      var serverMessage = responseData['message'];
      if (responseData['status'] == "success") {
        return OrderDetails.fromJson(responseData);
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      showCustomToast("Error while conneting to server");
      throw Exception("Error getting response  ${response.statusCode}");
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arrCategories = _getOrders();
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
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Orders"),
          ),
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     bottom: 12,
                //   ),
                // ),
                // CategoryList(arrCategories: _arrCategories),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: Column(
                    children: [
                      Container(
                        child: FutureBuilder(
                            initialData: null,
                            future: _arrCategories,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var categories = snapshot.data.orderData;
                                return ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      OrderData orderData = categories[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: OrdersItem(
                                          orderData: orderData,
                                        ),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Container(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
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
    @required Future<OrderDetails> arrCategories,
  })  : _arrCategories = arrCategories,
        super(key: key);

  final Future<OrderDetails> _arrCategories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [
                Container(
                  child: FutureBuilder(
                      initialData: null,
                      future: _arrCategories,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var categories = snapshot.data.orderData;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: categories.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                OrderData orderData = categories[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: OrdersItem(
                                    orderData: orderData,
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Container(),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
