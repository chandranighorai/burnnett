import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/Registration/RegMain.dart';
import 'package:burnett/userdata/UserPrefs.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
// import '../signup/SignUpScreen.dart';
// import '../userdata/UserPrefs.dart';
import '../util/AppColors.dart';
import '../util/Consts.dart';
// import '../util/Util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'LoginUserModel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //===========================
  String userEmail = "";
  String userPassword = "";
  String forgotEmail = "";
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  //========== Login handler =========
  void loginUser(BuildContext context) async {
    if (userEmail.trim() == "" || !isEmail(userEmail.trim())) {
      showCustomToast("Please enter email or phone.");
      return;
    }
    if (userPassword.trim() == "") {
      showCustomToast("Pleaase enter password");
      return;
    }
    var requestParam =
        "?email=" + userEmail.trim() + "&password=" + userPassword.trim();
    final http.Response response = await http.get(
      Uri.parse(Consts.LOGIN_USER + requestParam),
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverMessage = responseData['message'];
      if (responseData['status'] == "success") {
        var userData = responseData['userdata'];
        print(userData);
        LoginUserModel loginUserModel = LoginUserModel();

        loginUserModel.userId = userData['user_id'];
        loginUserModel.firstname = userData['firstname'];
        loginUserModel.lastname = userData['lastname'];
        loginUserModel.email = userData['email'];
        loginUserModel.userType = userData['user_type'];
        loginUserModel.phone = userData['phone'];
        saveUserLoginPrefs(loginUserModel);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        showCustomToast(serverMessage);
      }
    } else {
      // showCustomToast("Error while conneting to server");
      print("Error getting response  ${response.statusCode}");
      throw Exception("Error getting response  ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: Navigation(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "images/login_bg.jpg",
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14.0,
                    left: 40,
                    right: 40,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                              border: Border.all(
                                  color: AppColors.loginContainerBorder,
                                  width: 1),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: loginForm(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegMain(),
                              ),
                            )
                          }),
                      child: Text(
                        "Don`t have an account? Create One",
                        style: TextStyle(
                          color: AppColors.forgotcreateColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.forgotLoginColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 180,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          loginUser(context);
                          // ;
                        },
                        child: InkWell(
                          // onTap: (() => {
                          //       loginUser(context),
                          //     }),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Container(
                            height: 1.0,
                            width: MediaQuery.of(context).size.width - 280,
                            color: Colors.grey,
                          ),
                          Text(
                            " Or ",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          Container(
                            height: 1.0,
                            width: MediaQuery.of(context).size.width - 280,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Login With",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Image.asset(
                              "images/ic_goggle.png",
                              height: 30,
                            ),
                            onTap: (() => {}),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Image.asset(
                              "images/ic_facebook.png",
                              height: 30,
                            ),
                            onTap: (() => {}),
                          ),
                        ],
                      ),
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

  Widget navDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.

          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            // DrawerHeader(
            //   child: Text('Drawer Header'),
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            // ),
            ListTile(
              title: Text(
                'Item 1',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Item 2',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        Theme(
          data: ThemeData(
            primaryColor: Colors.redAccent,
            primaryColorDark: Colors.red,
          ),
          child: new TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFFD4DFE8),
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFFD4DFE8),
                  width: 2,
                ),
              ),
              hintText: 'Mobile / Email',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            onChanged: (value) => {
              setState(
                () {
                  userEmail = value;
                },
              )
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Theme(
          data: ThemeData(
            primaryColor: Colors.redAccent,
            primaryColorDark: Colors.red,
          ),
          child: new TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFFD4DFE8),
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0XFFD4DFE8),
                  width: 2,
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            obscureText: true,
            onChanged: (value) => {
              setState(
                () {
                  userPassword = value;
                },
              )
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       InkWell(
        //         onTap: _forgotDialogPopup,
        //         child: Text(
        //           "Forgot Password?",
        //           style: TextStyle(
        //             color: AppColors.forgotPasswordColor,
        //             fontSize: 15,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.appMainColor,
        //   ),
        //   width: MediaQuery.of(context).size.width,
        //   height: 50,
        //   child: TextButton(
        //     // onPressed: () {
        //     //   loginUser(context);
        //     //   ;
        //     // },
        //     child: Text(
        //       "Submit",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 30,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Don't have an account?",
        //       style: TextStyle(
        //         color: AppColors.loginTextColor,
        //         fontSize: 15,
        //       ),
        //     ),
        //     SizedBox(
        //       width: 5,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         Navigator.pop(
        //           context,
        //         );
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             // builder: (context) => SignUpScreen(),
        //           ),
        //         );
        //       },
        //       child: Text(
        //         "Sign up",
        //         style: TextStyle(
        //           color: AppColors.forgotPasswordColor,
        //           fontSize: 15,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 80,
        // ),
      ],
    );
  }

  void _forgotDialogPopup() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await showDialog(
            // context: context,
            builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Colors.white,
            ),
            child: AlertDialog(
              title: Text(
                "Forgot password",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: StatefulBuilder(
                // You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                  // return ForgotPassword();
                },
              ),
            ),
          );
        });
      },
    );
  }
}
