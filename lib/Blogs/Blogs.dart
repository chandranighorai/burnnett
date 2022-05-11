import 'package:burnett/Blogs/blogDetails.dart';
import 'package:burnett/Blogs/blogModel.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  BlogData blogD;
  Blogs({this.blogD, Key key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlogDetails(
              title: widget.blogD.blogTitle,
              desc:widget.blogD.description
            )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0)],
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.02))),
          child: Text(widget.blogD.blogTitle),
        ),
      ),
    );
  }
}
