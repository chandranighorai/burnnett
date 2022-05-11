import 'package:burnett/ProductDetails/ProductModel.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:flutter/material.dart';

class ViewAllReviews extends StatefulWidget {
  List<ProductReview> reviewList;
  ViewAllReviews({this.reviewList, Key key}) : super(key: key);

  @override
  _ViewAllReviewsState createState() => _ViewAllReviewsState();
}

class _ViewAllReviewsState extends State<ViewAllReviews> {
  @override
  Widget build(BuildContext context) {
    print("reviewList..." + widget.reviewList.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBannerColor,
        toolbarHeight: 40,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        title: Center(
          child: Text(
            "All Reviews",
          ),
        ),
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
        child: ListView.builder(
            itemCount: widget.reviewList.length,
            itemBuilder: (BuildContext context, int index) {
              ProductReview review = widget.reviewList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          MediaQuery.of(context).size.width * 0.02)),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // RatingBar.builder(
                      //   initialRating: 5,
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemSize: 20,
                      //   unratedColor: Colors.grey,
                      //   //glowColor: Colors.red,
                      //   itemPadding: EdgeInsets.symmetric(
                      //       horizontal: 4.0),
                      //   itemBuilder: (context, _) => Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // ),
                      Text(
                        review.name,
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
                        review.message,
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
                        review.dateAdded,
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
            }),
      ),
    );
  }
}
