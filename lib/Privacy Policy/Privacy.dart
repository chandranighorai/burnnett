import 'dart:convert';

import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var describtion;
  bool dataLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    _getPrivacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text("Privacy Policy"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          // child: dataLoad == false
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : Html(
          //         data: describtion,
          //       ),
          child: dataLoad == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  describtion,
                ),
        ),
      ),
    );
  }

  _getPrivacy() async {
    try {
      var response = await http.get(Uri.parse(Consts.policy));
      print("Response data..." + response.body.toString());
      var responseData = jsonDecode(response.body);
      if (responseData["status"] == "success") {
        describtion = responseData["respData"][0]["description"];
      }
      setState(() {
        dataLoad = true;
      });
      print("Describtion..." + describtion.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
