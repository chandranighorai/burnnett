import 'package:burnett/Address/AllAdressScreen.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/MyReview/MyReviews.dart';
import 'package:burnett/Product%20Orders/Orders.dart';
import 'package:burnett/ProductDetails/ViewAllReviews.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/wishlist/Wishlist.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  var userId;
  MyAccount({this.userId});
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchKey = "";
    openSearch = false;
  }

  final double shapeHeight = 160;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBannerColor,
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
        title: Text("My Account"),
        toolbarHeight: 40,
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Orders",
                              style: headingtextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Orders(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "View All Orders",
                                    style: bottomLinktextStyle,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        // ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Favourites",
                              style: headingtextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Wishlist(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "View All Favourites Items",
                                    style: bottomLinktextStyle,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Addresses",
                              style: headingtextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllAdressScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "View All Address",
                                    style: bottomLinktextStyle,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    // MY Reviews
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Reviews",
                              style: headingtextStyle,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyReviews(userId: widget.userId)));
                                  },
                                  child: Text(
                                    "View All Reviews",
                                    style: bottomLinktextStyle,
                                  ),
                                ),
                              ],
                            )
                          ],
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
    );
  }
}
