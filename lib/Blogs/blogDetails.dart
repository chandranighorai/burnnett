import 'package:flutter/material.dart';

class BlogDetails extends StatelessWidget {
  var title, desc;
  BlogDetails({this.title, this.desc, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Blog Details",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Text(
                desc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
