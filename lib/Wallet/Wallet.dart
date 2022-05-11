import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/AppColors.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,

        title:
        Center(
          child: Text(
            "My Account",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
actions: [
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: Icon(
          Icons.edit
        ),
      )
    ],
  )
],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/login_bg.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    // bottom: 14.0,
                    left: 40,
                    right: 40,
                  ),
                  child: Align(
                    // alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //
                          // SizedBox(
                          //   height: 30,
                          // ),
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
                              child: Column(
                                children: [
                                  walletForm(context),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 2,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(

                            width: MediaQuery.of(context).size.width - 180,
                            height: 50,
                            child: Column(
                              children: [
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                    // color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Wallet balance: 100",
                                  style: TextStyle(
                                    // color: Colors.black,
                                    fontSize: 20,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget walletForm(BuildContext context) {
    return Container(
      height: 292,
      child: SingleChildScrollView(
        child: Column(
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
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) => {
                  // setState(
                  //   () {
                  //     userEmail = value;
                  //   },
                  // )
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
                  hintText: 'Mobile',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) => {
                  // setState(
                  //   () {
                  //     userEmail = value;
                  //   },
                  // )
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
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) => {
                  // setState(
                  //   () {
                  //     userPassword = value;
                  //   },
                  // )
                },
              ),
            ),

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
                  hintText: 'Others 1',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) => {
                  // setState(
                  //   () {
                  //     userPassword = value;
                  //   },
                  // )
                },
              ),
            ),
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
                  hintText: 'Others 2',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) => {
                  // setState(
                  //   () {
                  //     userPassword = value;
                  //   },
                  // )
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }

}
