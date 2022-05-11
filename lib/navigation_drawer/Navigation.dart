// import 'package:Grocery/shopping_cart/ShoppingCartScreen.dart';
import 'package:burnett/Address/AddAddress.dart';
import 'package:burnett/Blogs/blogList.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/Privacy%20Policy/Privacy.dart';
import 'package:burnett/Product%20Orders/Orders.dart';
import 'package:burnett/Sub_category/ProductCategory.dart';
import 'package:burnett/Wallet/My_account.dart';
import 'package:burnett/Wallet/Wallet.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../my_account/MyAccountScreen.dart';
// import '../Orders/MyOrdersScreen.dart';
import '../login/LoginScreen.dart';
// import '../product_details/ProductDetails.dart';
// import '../category_list/CategorytListScreen.dart';
import '../util/AppColors.dart';
// import '../util/Util.dart';

class Navigation extends StatefulWidget {
  @override
  _Navigation createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  Future<int> _counter;
  var userData = {};
  String userId;

  Future<Object> _checkUserIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    String fname = prefs.getString("fname");
    String lname = prefs.getString("lname");
    userId = prefs.getString("user_id");
    if (email == null) return null;
    userData.putIfAbsent("userEmail", () => email);
    userData.putIfAbsent("userName", () => fname + ' ' + lname);

    return userData;
  }

  void _logout(BuildContext context) {
    showAlertDialogWithCancel(context, "Are you sure?", () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // _checkUserIsLoggedIn().then((String email) {
    //   debugPrint(email);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _checkUserIsLoggedIn();
    //   // debugPrint(email);
    // });
  }

  @override
  Widget build(BuildContext context) {
// return MaterialApp(

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
// Important: Remove any padding from the ListView.

          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
// AssetImage(image: 'images/image_bg.png'),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        // border: Border.all(color: Colors.white, width: 0.5),
                        image: DecorationImage(
                          image: AssetImage(
                            "images/login_bg.jpg",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
// child: Image.asset("images/image_bg.png"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    FutureBuilder(
                      initialData: null,
                      future: _checkUserIsLoggedIn(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var userObject = snapshot.data;
                          return Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  userObject['userName'] == null
                                      ? ""
                                      : userObject['userName'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  userObject['userEmail'] == null
                                      ? ""
                                      : userObject['userEmail'],
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0XFFFFFF),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 1,
                color: Color(0XFFe0e0e0),
              ),
            ),
            ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   if (snapshot.hasData) {
              //     debugPrint("has data");
              //     var userObject = snapshot.data;
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         // builder: (context) => MyAccountScreen(),
              //       ),
              //     );
              //   } else {
              //     debugPrint("no data");
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => HomePage(),
              //       ),
              //     );
              //   }
              // },
              title: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),

            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductCategory(),
                  ),
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAccount(userId: userId),
                  ),
                );
              },
              title: Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Account',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(
            //         Icons.favorite,
            //         color: Colors.yellow,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'My Wishlist',
            //         style: TextStyle(
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Wallet(),
            //       ),
            //     );
            //   },
            // ),
            FutureBuilder(
              initialData: null,
              future: _checkUserIsLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    if (snapshot.hasData) {
                      debugPrint("has data");

                      var userObject = snapshot.data;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Orders(),
                        ),
                      );
                    } else {
                      debugPrint("no data");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Orders(),
                        ),
                      );
                    }
                  },
                  title: Row(
                    children: [
                      Icon(
                        Icons.article,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.lock_open_rounded,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Blog',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BlogList()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.help,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Help Center',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // FutureBuilder(
            //   initialData: null,
            //   future: _checkUserIsLoggedIn(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     return ListTile(
            //       onTap: () {
            //         Navigator.pop(context);
            //         if (snapshot.hasData) {
            //           debugPrint("has data");
            //
            //           var userObject = snapshot.data;
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               // builder: (context) => ShoppingCartScreen(),
            //             ),
            //           );
            //         } else {
            //           debugPrint("no data");
            //
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => LoginScreen(),
            //             ),
            //           );
            //         }
            //       },
            //       title: Text(
            //         'View Cart',
            //         style: TextStyle(
            //           color: Colors.black,
            //         ),
            //       ),
            //     );
            //   },
            // ),

            // ListTile(
            //   title: Text(
            //     'My Orders',
            //     style: TextStyle(
            //       color: Colors.black,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            FutureBuilder(
              initialData: null,
              future: _checkUserIsLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _logout(context);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
