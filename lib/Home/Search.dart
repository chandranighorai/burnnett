import 'dart:convert';
import 'dart:ui';

import 'package:burnett/Home/SearchItem.dart';
import 'package:burnett/Home/SearchModel.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController;
  Future<SearchModel> _Searchlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = new TextEditingController();
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
            "Search",
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.06),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.15,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                      Radius.circular(MediaQuery.of(context).size.width * 50))),
              child: TextFormField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    //showCustomToast("Didn't search yet");
                    print("Value..." + value.toString());
                    _searchItem(value.toString());
                  }
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
                child: FutureBuilder(
              initialData: null,
              future: _Searchlist,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data.productdata;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        //print("Product length..." + data.length);
                        Productdata productdata = data[index];
                        return SearchItem(searchItems: productdata);
                      });
                } else {
                  return _searchController.text.isEmpty
                      ? Center(child: Text("No search Yet"))
                      : Center(child: CircularProgressIndicator());
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  _searchItem(String searchVal) {
    var inputData = "/?keyword=";
    inputData += searchVal;
    print("Input..." + inputData.toString());
    setState(() {
      _Searchlist = _getSearchList(inputData);
    });
  }

  Future<SearchModel> _getSearchList(String inputData) async {
    try {
      var url = Uri.parse(Consts.search + inputData);
      print("URL..." + url.toString());
      var response = await http.get(url);
      print("response...." + response.body);
      var resposeData = jsonDecode(response.body);
      return SearchModel.fromJson(resposeData);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
