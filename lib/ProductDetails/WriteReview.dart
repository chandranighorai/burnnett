import 'dart:convert';

import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WriteReview extends StatefulWidget {
  String productId;
  String userId;
  String userName;
  String userEmail;

  WriteReview(
      {this.productId, this.userId, this.userName, this.userEmail, Key key})
      : super(key: key);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  TextEditingController _reviewMsg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewMsg = new TextEditingController();
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            "Review",
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        //color: Colors.amber,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02))),
              child: TextFormField(
                controller: _reviewMsg,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Write Your Review...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            InkWell(
              onTap: () {
                if (_reviewMsg.text.isEmpty) {
                  //print("message box empty");
                  showCustomToast("Write something...");
                } else {
                  _submitReview();
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02))),
                child: Text(
                  "Submit Review".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _submitReview() async {
    print("product_id..." + widget.productId.toString());
    print("product_id..." + widget.userId.toString());
    print("product_id..." + widget.userName.toString());
    print("product_id..." + widget.userEmail.toString());
    print("product_id..." + _reviewMsg.toString());

    try {
      var response = "?";
      response += "product_id=" +
          widget.productId +
          "&user_id=" +
          widget.userId +
          "&name=" +
          widget.userName +
          "&email_id=" +
          widget.userEmail +
          "&message=" +
          _reviewMsg.text.trim().toString();
      var submitReview = Uri.parse(Consts.add_review + response);
      print("SubmitReview..." + submitReview.toString());
      var responseData = await http.get(submitReview);
      var reviewResponse = jsonDecode(responseData.body);
      showCustomToast(reviewResponse["message"].toString());
      _reviewMsg.text = "";
      print("response..." + responseData.body.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
