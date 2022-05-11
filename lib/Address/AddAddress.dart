import 'dart:convert';

import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:burnett/util/Consts.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AllAdressScreen.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String _addressType;
  String selectpType = "State";
  double shapeHeight = 140;
  // String flatName, streetName, landMark, areaName, zipCode;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController mobileNumberController;
  TextEditingController flatNumberController;
  TextEditingController localityController;
  TextEditingController landMarkController;
  TextEditingController areaNameController;
  TextEditingController zipCodeController;
  TextEditingController cityController;
  TextEditingController countryController;

  var mAddress = {};
  String newAddress;
  @override
  void initState() {
    //===================================
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    flatNumberController = TextEditingController();
    localityController = TextEditingController();
    landMarkController = TextEditingController();
    areaNameController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    zipCodeController = TextEditingController();

    nameController.text = "";
    emailController.text = "";
    mobileNumberController.text = "";
    flatNumberController.text = "";
    localityController.text = "";
    landMarkController.text = "";
    areaNameController.text = "";
    zipCodeController.text = "";
    cityController.text = "";
    countryController.text = "";
    _addressType = "";

    newAddress = "My new address.\nKolkata";
    mAddress['id'] = "333";
    mAddress['address'] = newAddress;

    getSharedPrefs();
    //===================================
    super.initState();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var mobile = prefs.getString("phone");
    var fName = prefs.getString("fname");
    var lName = prefs.getString("lname");
    setState(() {
      mobileNumberController = new TextEditingController(text: mobile);
      //emailController = new TextEditingController(text: email);
      emailController = new TextEditingController(text: email);
      nameController = new TextEditingController(text: fName + ' ' + lName);
    });
  }

  _showDiaolog() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await showDialog(
            context: context,
            useSafeArea: true,
            builder: (BuildContext context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogBackgroundColor: Colors.white,
                ),
                child: AlertDialog(
                  title: null,
                  content: StatefulBuilder(
                    // You need this, notice the parameters below:
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 60,
                            color: AppColors.appMainColor,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Your Order is placed successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "You can track your order from my order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                              ),
                              child: Center(
                                child: TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         CategorytListScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'Checkout',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            });
      },
    );
  }

  _addNewAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(selectpType);
    var user_id = prefs.getString('user_id');
    if (nameController.text == null || nameController.text.trim() == "") {
      showCustomToast("Please enter name");
      return;
    }
    if (mobileNumberController.text == null ||
        mobileNumberController.text.trim() == "") {
      showCustomToast("Please enter mobile number");
      return;
    }

    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(mobileNumberController.text)) {
      showCustomToast("Please enter valid mobile number");
      return;
    }

    if (emailController.text == null || emailController.text.trim() == "") {
      showCustomToast("Please enter email");
      return;
    }
    if (flatNumberController.text == null ||
        flatNumberController.text.trim() == "") {
      showCustomToast("Please enter flat number");
      return;
    }
    if (localityController.text == null ||
        localityController.text.trim() == "") {
      showCustomToast("Please enter locality");
      return;
    }
    if (landMarkController.text == null ||
        landMarkController.text.trim() == "") {
      showCustomToast("Please enter landmark");
      return;
    }
    // if(areaNameController.text == null || areaNameController.text.trim() ==""){
    //   showCustomToast("Please enter area name");
    //   return;
    // }
    if (zipCodeController.text == null || zipCodeController.text.trim() == "") {
      showCustomToast("Please enter zipcode");
      return;
    }
    if (_addressType == null || _addressType == "") {
      showCustomToast("Please select address type");
      return;
    }

    if (selectpType.toString() == "") {
      showCustomToast("Please select State type" + selectpType);
      return;
    }
    if (cityController.text == null || cityController.text.trim() == "") {
      showCustomToast("Please enter city");
      return;
    }
    if (countryController.text == null || countryController.text.trim() == "") {
      showCustomToast("Please enter country");
      return;
    }
    print("AddressType..." + selectpType.trim().toString());
    print("AddressType..." + _addressType.toString());

    var requestParam = "?user_id=" + user_id;
    requestParam += "&name=" + nameController.text;
    requestParam += "&phone=" + mobileNumberController.text.trim();
    requestParam += "&email=" + emailController.text.trim();
    requestParam +=
        "&flat_house_floor_building=" + flatNumberController.text.trim();
    requestParam += "&locality=" + localityController.text.trim();
    requestParam += "&landmark=" + landMarkController.text.trim();
    requestParam += "&city=" + cityController.text.trim();
    requestParam += "&state=" + selectpType.trim();
    requestParam += "&country=" + countryController.text.trim();
    requestParam += "&address_type=" + _addressType;
    requestParam += "&pincode=" + zipCodeController.text.trim();
    requestParam += "&default_billing=1";
    debugPrint("${Uri.parse(Consts.addNewAddress + requestParam)}");

    final http.Response response = await http.get(
      Uri.parse(Consts.addNewAddress + requestParam),
    );
    print(Uri.parse(Consts.addNewAddress + requestParam));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var serverCode = responseData['code'];
      var serverMessage = responseData['message'];

      if (serverCode == "200") {
        var rowId = responseData["row_id"].toString();
        print(responseData);
        if (int.parse(rowId) > 0) {
          setState(() {
            mobileNumberController.clear();
            flatNumberController.clear();
            localityController.clear();
            landMarkController.clear();
            areaNameController.clear();
            zipCodeController.clear();
            cityController.clear();
            countryController.clear();
            // _addressType = "";
            // selectpType = "";
          });
        }
        showCustomToast(serverMessage);
      } else {
        showCustomToast(serverMessage);
      }
    }
  }

  _selectAddress(String addresstype) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        // print("MAddress...." + mAddress.toString());
        // FocusScope.of(context).unfocus();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(),
        //   ),
        // );
        // Navigator.pop(
        //   context,
        //   mAddress,
        // );
        Navigator.pop(context);
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AllAdressScreen(),
          ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.appBannerColor,
          toolbarHeight: 40,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllAdressScreen(),
                  ),
                );
              }),
          title: Text(
            "Burnett",
            // style: TextStyle(
            //   fontFamily: "Philosopher",
            //   fontSize: 36,
            // ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/login_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(children: [
                    customShape(),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: new EdgeInsets.only(
                        top: shapeHeight * .50,
                        right: 20.0,
                        left: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: Color(0XFFf9f7f7),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0XFFf9f7f7),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15,
                            bottom: 25,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Name"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Mobile Number"),
                              SizedBox(
                                height: 20,
                              ),

                              buildTextField("Email"),
                              SizedBox(
                                height: 20,
                              ),

                              buildTextField("Flat Number"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Locality"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Landmark"),
                              // SizedBox(height: 20,),
                              // buildTextField("Area Name"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Zip Code"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Add City"),
                              SizedBox(
                                height: 20,
                              ),
                              buildTextField("Add Country"),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.white,
                                      ),
                                      child: DropdownButton(
                                        hint: Text(
                                          "State",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value: selectpType,
                                        // isDense: true,
                                        isExpanded: true,
                                        onChanged: (newValue) {
                                          print("SelectType..." +
                                              selectpType.toString());
                                          setState(() {
                                            selectpType = newValue;
                                          });
                                          print("SelectType...0.." +
                                              selectpType.toString());
                                          // productDetailsModel.productAttribute
                                          //     .map((String map) {
                                          // if (map.name == newValue) {
                                          //   setState(() {
                                          //     selectPrice =
                                          //         double.parse(map.productPrice.toString());
                                          //     demoPrice =
                                          //         double.parse(map.productPrice.toString());
                                          //   });
                                          //   _handleFetchCart();
                                          //   if (isadd) {
                                          //     setState(() {
                                          //       seleType = newValue;
                                          //     });
                                          //   } else {}
                                          // }
                                          // print(
                                          //     selectpType);
                                          // }).toList();
                                        },
                                        // style: ,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        items: [
                                          'State',
                                          'Andhra Pradesh',
                                          'Arunachal Pradesh',
                                          'Assam',
                                          'Bihar',
                                          'Chandigarh',
                                          'Chhattisgarh',
                                          'Dadra and Nagar Haveli',
                                          'Daman and Diu',
                                          'Delhi',
                                          'Goa',
                                          'Gujarat',
                                          'Haryana',
                                          'Himachal Pradesh',
                                          'Jammu and Kashmir',
                                          'Jharkhand',
                                          'Karnataka',
                                          'Kenmore',
                                          'Kerala',
                                          'Lakshadweep',
                                          'Madhya Pradesh',
                                          'Maharashtra',
                                          'Manipur',
                                          'Meghalaya',
                                          'Mizoram',
                                          'Nagaland',
                                          'Narora',
                                          'Natwar',
                                          'Odisha',
                                          'Paschim Medinipur',
                                          'Pondicherry',
                                          'Punjab',
                                          'Rajasthan',
                                          'Sikkim',
                                          'Tamil Nadu',
                                          'Telangana',
                                          'Tripura',
                                          'Uttar Pradesh',
                                          'Uttarakhand',
                                          'Vaishali',
                                          'West Bengal',
                                        ].map((value1) {
                                          return DropdownMenuItem(
                                            value: value1,
                                            child: new Text(
                                              value1,
                                              style: new TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.red),
                                    child: Radio(
                                        activeColor: Colors.black,
                                        value: "Home",
                                        groupValue: _addressType,
                                        onChanged: (value) => {
                                              //_selectAddress(value),
                                              setState(() {
                                                _addressType = value;
                                              }),
                                              print("AddressType..." +
                                                  _addressType.toString())
                                            }),
                                  ),
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            AppColors.appBarColor),
                                    child: Radio(
                                        activeColor: Colors.black,
                                        value: "Office",
                                        groupValue: _addressType,
                                        onChanged: (value) => {
                                              //_selectAddress(value),
                                              setState(() {
                                                _addressType = value;
                                              }),
                                              print("AddressType..." +
                                                  _addressType.toString())
                                            }),
                                  ),
                                  Text(
                                    "Office",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.appMainColor,
                                  // borderRadius: ,
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    _addNewAddress();
                                  },
                                  child: Text(
                                    "Add Address",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customShape() {
    return ClipPath(
      child: Container(
        // height: shapeHeight,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 35,
            right: 35,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Add Adress",
                style: TextStyle(
                  fontFamily: "Philosopher",
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      style: TextStyle(color: Colors.black),
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
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      controller: hintText == "Name"
          ? nameController
          : hintText == "Mobile Number"
              ? mobileNumberController
              : (hintText == "Email")
                  ? emailController
                  : (hintText == "Flat Number")
                      ? flatNumberController
                      : (hintText == "Locality")
                          ? localityController
                          : (hintText == "Landmark")
                              ? landMarkController
                              : (hintText == "Area name")
                                  ? areaNameController
                                  : (hintText == "Zip Code")
                                      ? zipCodeController
                                      : (hintText == "Add City")
                                          ? cityController
                                          : (hintText == "Add Country")
                                              ? countryController
                                              : null,
      onChanged: (value) => {
        setState(() {
          if (hintText == "Name") {
            nameController.text = value;
            nameController.selection = TextSelection.fromPosition(
                TextPosition(offset: nameController.text.length));
          } else if (hintText == "Mobile Number") {
            mobileNumberController.text = value;
            mobileNumberController.selection = TextSelection.fromPosition(
                TextPosition(offset: mobileNumberController.text.length));
          } else if (hintText == "Email") {
            emailController.text = value;
            emailController.selection = TextSelection.fromPosition(
                TextPosition(offset: emailController.text.length));
          } else if (hintText == "Flat Number") {
            flatNumberController.text = value;
            flatNumberController.selection = TextSelection.fromPosition(
                TextPosition(offset: flatNumberController.text.length));
          } else if (hintText == "Locality") {
            localityController.text = value;
            localityController.selection = TextSelection.fromPosition(
                TextPosition(offset: localityController.text.length));
          } else if (hintText == "Landmark") {
            landMarkController.text = value;
            landMarkController.selection = TextSelection.fromPosition(
                TextPosition(offset: landMarkController.text.length));
          } else if (hintText == "Area name") {
            areaNameController.text = value;
            areaNameController.selection = TextSelection.fromPosition(
                TextPosition(offset: areaNameController.text.length));
          } else if (hintText == "Zip Code") {
            zipCodeController.text = value;
            zipCodeController.selection = TextSelection.fromPosition(
                TextPosition(offset: zipCodeController.text.length));
          } else if (hintText == "Add City") {
            cityController.text = value;
            cityController.selection = TextSelection.fromPosition(
              TextPosition(offset: cityController.text.length),
            );
          } else if (hintText == "Add Country") {
            countryController.text = value;
            countryController.selection = TextSelection.fromPosition(
                TextPosition(offset: countryController.text.length));
          }
        }),
      },
    );
  }
}
