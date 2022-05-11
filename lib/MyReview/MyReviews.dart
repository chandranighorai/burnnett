import 'dart:convert';

import 'package:burnett/MyReview/MyReviewList.dart';
import 'package:burnett/util/Consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyReviews extends StatefulWidget {
  var userId;
  MyReviews({this.userId, Key key}) : super(key: key);

  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  var responseData;
  bool dataload;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataload = false;
    _myRviewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My reviews"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: dataload == false
            ? Center(child: CircularProgressIndicator())
            : responseData.length == 0
                ? Center(
                    child: Text("No Reviews Added yet"),
                  )
                : ListView.builder(
                    itemCount: responseData.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("RList..." + responseData[index].toString());
                      return MyReviewList(rList: responseData[index]);
                    }),
      ),
    );
  }

  _myRviewList() async {
    try {
      var userId = "/?user_id=" + widget.userId;
      var url = Uri.parse(Consts.my_review + userId);
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      print("Response..." + responseBody.toString());
      if (responseBody["status"].toString() == "success") {
        responseData = responseBody["respData"];
      }
      print("Response...0.." + responseBody["respData"].toString());

      setState(() {
        dataload = true;
      });
      //return MyReviewModel.fromJson(responseBody);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
