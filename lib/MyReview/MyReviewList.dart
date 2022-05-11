import 'package:flutter/material.dart';

class MyReviewList extends StatelessWidget {
  var rList;
  MyReviewList({this.rList, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("RList..." + rList.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.02)),
            border: Border.all(color: Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rList["message"].toString(),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Color(0XFF474747),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              rList["product_title"].toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0XFF474747),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              rList["name"].toString(),
              style: TextStyle(
                fontSize: 10,
                //fontWeight: FontWeight.bold,
                color: Color(0XFF474747),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              rList["date_added"].toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0XFF474747),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Text("Description"),
          ],
        ),
      ),
    );
  }
}
