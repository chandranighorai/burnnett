import 'dart:convert';

import 'package:burnett/Blogs/Blogs.dart';
import 'package:burnett/Blogs/blogModel.dart';
import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogList extends StatefulWidget {
  const BlogList({Key key}) : super(key: key);

  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  var responseData;
  bool dataLoad;
  @override
  void initState() {
    // TODO: implement initState
    _getBlogList();
    dataLoad = false;
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
            child: Text("Blogs"),
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: FutureBuilder(
            initialData: null,
            future: _getBlogList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var blogDataList = snapshot.data.blogdata;
                return ListView.builder(
                    itemCount: blogDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      BlogData blogData = blogDataList[index];
                      return Blogs(blogD: blogData);
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  Future<BlogModel> _getBlogList() async {
    try {
      var url = Uri.parse(Consts.blogs);
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      print("responseDta..." + responseBody.toString());
      responseData = responseBody["respData"];
      return BlogModel.fromJson(responseBody);
      // setState(() {
      //   dataLoad = true;
      // });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
