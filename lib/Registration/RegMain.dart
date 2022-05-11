import 'dart:io';

import 'package:burnett/Home/HomePage.dart';
import 'package:burnett/login/LoginScreen.dart';
import 'package:burnett/userdata/UserPrefs.dart';
import 'package:burnett/util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../util/AppColors.dart';
import '../util/Consts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'RegisterModel.dart';

class RegMain extends StatefulWidget {
  @override
  _RegMain createState() => _RegMain();
}

class _RegMain extends State<RegMain> {
  String _chosenValue;
  String radioButtonItem = "Yes",
      radioButtonItemdist = "",
      radioButtonItemstockist = "";
  String user_type = "",
      firstname = "",
      lastname = "",
      phone = "",
      whatsapp = "",
      have_registration_no = "",
      registration_no = "",
      firmname = "",
      drug_license_no = "",
      gst_pan_no_firm = "",
      address = "",
      area_of_work = "",
      // prev_any_delarship = "",
      name_of_company = "",
      target_of_business = "",
      year_of_experience = "",
      email = "",
      password = "",
      cpassword = "";
  bool isUser = false,
      isDoctor = false,
      isDistributor = false,
      isStockist = false;
  int id;
  File _image;
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void registerUser(BuildContext context) async {
    print('hello world');
    // field();
    if (_chosenValue == "User") {
      field();
      var requestParam = "?";
      requestParam += "firstname=" + firstname;
      requestParam += "&lastname=" + lastname;
      requestParam += "&email=" + email;
      requestParam += "&phone=" + phone;
      requestParam += "&password=" + password;
      requestParam += "&whatsapp=" + whatsapp;
      requestParam += "&user_type=CU";
      print(requestParam);
      final http.Response response = await http.get(
        Uri.parse(Consts.SIGNUP_USER + requestParam),
      );
      // print(response);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['message'];
        var serverCode = responseData['code'];
        if (serverCode == "200") {
           print(responseData);
          RegisterUserModel registerUserModel = RegisterUserModel();

          registerUserModel.userId =
              responseData['user_id'];
          registerUserModel.firstname = responseData['firstname'];
          registerUserModel.lastname = responseData['lastname'];
          registerUserModel.email = responseData['email'];
          registerUserModel.userType = responseData['user_type'];
          registerUserModel.phone = responseData['phone'];

          saveUserRegistrationPrefs(registerUserModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showCustomToast(serverMessage);
        }
      } else {}
    } else if (_chosenValue == "Doctor") {
      field();
      if (registration_no.trim() == "") {
        showCustomToast("Please enter Registration Id");
        return;
      }
      var requestParam = "?";
      requestParam += "firstname=" + firstname;
      requestParam += "&lastname=" + lastname;
      requestParam += "&email=" + email;
      requestParam += "&phone=" + phone;
      requestParam += "&password=" + password;
      requestParam += "&whatsapp=" + whatsapp;
      requestParam += "&have_registration_no=" + radioButtonItem;
      requestParam += "&registration_no=" + registration_no;
      requestParam += "&user_type=DR";
      print(requestParam);
      final http.Response response = await http.get(
        Uri.parse(Consts.SIGNUP_USER + requestParam),
      );
      print(requestParam);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['message'];
        var serverCode = responseData['code'];
        // print(response);
        if (serverCode == "200") {
          RegisterUserModel registerUserModel = RegisterUserModel();

          registerUserModel.userId = responseData['user_id'];
          registerUserModel.firstname = responseData['firstname'];
          registerUserModel.lastname = responseData['lastname'];
          registerUserModel.email = responseData['email'];
          registerUserModel.userType = responseData['user_type'];
          registerUserModel.phone = responseData['phone'];

          saveUserRegistrationPrefs(registerUserModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showCustomToast(serverMessage);
        }
      }else{
        showCustomToast('Your Email Is Already Used.');
      }
    } else if (_chosenValue == "Distributor") {
      field();
      distvalida();
      var requestParam = "?";
      requestParam += "firstname=" + firstname;
      requestParam += "&lastname=" + lastname;
      requestParam += "&email=" + email;
      requestParam += "&phone=" + phone;
      requestParam += "&password=" + password;
      requestParam += "&have_registration_no=" + radioButtonItemdist;
      requestParam += "&registration_no=" + registration_no;
      requestParam += "&firmname=" + firmname;
      requestParam += "&drug_license_no=" + drug_license_no;
      requestParam += "&gst_pan_no_firm=" + gst_pan_no_firm;
      requestParam += "&address=" + address;
      requestParam += "&area_of_work=" + area_of_work;
      requestParam += "&name_of_company=" + name_of_company;
      requestParam += "&target_of_business=" + target_of_business;
      requestParam += "&year_of_experience=" + year_of_experience;
      requestParam += "&user_type=CU";
      final http.Response response = await http.get(
        Uri.parse(Consts.SIGNUP_USER + requestParam),
      );
      print(response);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['message'];
        var serverCode = responseData['code'];
        print(response);
        if (serverCode == "200") {
          RegisterUserModel registerUserModel = RegisterUserModel();

          registerUserModel.userId =responseData['user_id'];
          registerUserModel.firstname = responseData['firstname'];
          registerUserModel.lastname = responseData['lastname'];
          registerUserModel.email = responseData['email'];
          registerUserModel.userType = responseData['user_type'];
          registerUserModel.phone = responseData['phone'];

          saveUserRegistrationPrefs(registerUserModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showCustomToast(serverMessage);
        }
      }
    } else if (_chosenValue == "Stockist") {
      field();
      distvalida();
      var requestParam = "?";
      requestParam += "firstname=" + firstname;
      requestParam += "&lastname=" + lastname;
      requestParam += "&email=" + email;
      requestParam += "&phone=" + phone;
      requestParam += "&password=" + password;
      requestParam += "&whatsapp=" + whatsapp;
      requestParam += "&have_registration_no=" + radioButtonItemdist;
      requestParam += "&registration_no=" + registration_no;
      requestParam += "&firmname=" + firmname;
      requestParam += "&drug_license_no=" + drug_license_no;
      requestParam += "&gst_pan_no_firm=" + gst_pan_no_firm;
      requestParam += "&address=" + address;
      requestParam += "&area_of_work=" + area_of_work;
      requestParam += "&name_of_company=" + name_of_company;
      requestParam += "&target_of_business=" + target_of_business;
      requestParam += "&user_type=CU";

      final http.Response response = await http.get(
        Uri.parse(Consts.SIGNUP_USER + requestParam),
      );
      print(response);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var serverMessage = responseData['message'];
        var serverCode = responseData['code'];
        print(response);
        if (serverCode == "200") {
          RegisterUserModel registerUserModel = RegisterUserModel();

          registerUserModel.userId =responseData['user_id'];
          registerUserModel.firstname = responseData['firstname'];
          registerUserModel.lastname = responseData['lastname'];
          registerUserModel.email = responseData['email'];
          registerUserModel.userType = responseData['user_type'];
          registerUserModel.phone = responseData['phone'];

          saveUserRegistrationPrefs(registerUserModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showCustomToast(serverMessage);
        }
      }
    } else {
      field();
    }
  }

  void field() {
    if (firstname == "") {
      showCustomToast("Please enter first name.");
      return;
    }
    if (lastname == "") {
      showCustomToast("Please enter last name.");
      return;
    }
    if (phone == "") {
      showCustomToast("Please enter mobile.");
      return;
    }
    if (email == "" || !isEmail(email)) {
      showCustomToast("Please enter a valid email.");
      return;
    }
    if (password == "") {
      showCustomToast("Pleaase enter password");
      return;
    }
    if (cpassword == "" || cpassword != password) {
      showCustomToast("Please enter confirm password or password dosn`t match");
      return;
    }

    // if (lastname.trim() == "") {}
    // if (lastname.trim() == "") {}
  }

  void distvalida() {
    if (firmname.trim() == "") {
      showCustomToast("Firm Name");
      return;
    }
    if (drug_license_no.trim() == "") {
      showCustomToast("Drug License No");
      return;
    }
    if (gst_pan_no_firm.trim() == "") {
      showCustomToast("GST No/PAN No Of Firm");
      return;
    }
    if (address.trim() == "") {
      showCustomToast("Address");
      return;
    }
    if (area_of_work.trim() == "") {
      showCustomToast("Area Name for Work");
      return;
    }
    if (radioButtonItemdist == "Yes") {
      if (name_of_company.trim() == "") {
        showCustomToast("Name of company");
        return;
      }
      if (target_of_business.trim() == "") {
        showCustomToast("Estimated Target of Business – (by amount in lacks)");
        return;
      }
      if (year_of_experience.trim() == "") {
        showCustomToast("How Many Year of Experience in this Field");
        return;
      }
    } else {
      if (target_of_business.trim() == "") {
        showCustomToast("Estimated Target of Business – (by amount in lacks)");
        return;
      }
      if (year_of_experience.trim() == "") {
        showCustomToast("How Many Year of Experience in this Field");
        return;
      }
    }

    if (radioButtonItemstockist == "Yes") {
      if (name_of_company.trim() == "") {
        showCustomToast("Name of company");
        return;
      }
      if (target_of_business.trim() == "") {
        showCustomToast("Estimated Target of Business – (by amount in lacks)");
        return;
      }
    } else {
      if (target_of_business.trim() == "") {
        showCustomToast("Estimated Target of Business – (by amount in lacks)");
        return;
      }
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/login_bg.jpg"), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 14.0,
                      left: 40,
                      right: 40,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                                border: Border.all(
                                    color: AppColors.loginContainerBorder,
                                    width: 1),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                    child: regisForm(context),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget regisForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SizedBox(
        //   height: 60,
        // ),
        Container(
          height: MediaQuery.of(context).size.height - 465,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'First Name',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            firstname = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Last Name',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            lastname = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Telephone Number',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            phone = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Whats App Number',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            whatsapp = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Email Id',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            email = value;
                          },
                        )
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) => {
                        setState(
                          () {
                            password = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Colors.redAccent,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
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
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) => {
                        setState(
                          () {
                            cpassword = value;
                          },
                        )
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size,
                    width: 318,
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      dropdownColor: Colors.white,
                      items: <String>[
                        'Select user type',
                        'User',
                        'Doctor',
                        'Distributor',
                        'Stockist'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select user type",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

//doctor
                  Container(
//added condation for doctor
                    child: _chosenValue == "Doctor"
                        ? Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.redAccent,
                                      primaryColorDark: Colors.red,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19),
                                          child: Text(
                                            "Have You any registration no",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  radioButtonItem = 'Yes';
                                                  id = 1;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Yes',
                                              style: new TextStyle(fontSize: 17.0),
                                            ),
                                            Radio(
                                              value: 2,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  radioButtonItem = 'No';
                                                  id = 2;
                                                });
                                              },
                                            ),
                                            Text(
                                              'No',
                                              style: new TextStyle(fontSize: 17.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.redAccent,
                                      primaryColorDark: Colors.red,
                                    ),
                                    child: radioButtonItem == "Yes"
                                        ? new TextField(
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
                                              hintText: 'Doctor Registration Id',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  registration_no = value;
                                                },
                                              )
                                            },
                                          )
                                        : Container(),
                                  ),
                                  Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.redAccent,
                                      primaryColorDark: Colors.red,
                                    ),
                                    child: radioButtonItem == "No"
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Doctor Chember Picture',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                  ),
                                  Column(
                                    children: [
                                      // radioButtonItem == "No"
                                      //     ? Container(
                                      //         decoration: BoxDecoration(
                                      //           color: Colors.grey,
                                      //           borderRadius: BorderRadius.all(
                                      //             Radius.circular(30),
                                      //           ),
                                      //         ),
                                      //         width: MediaQuery.of(context)
                                      //                 .size
                                      //                 .width -
                                      //             280,
                                      //         height: 40,
                                      //         child: radioButtonItem == "No"
                                      //             ? TextButton(
                                      //                 onPressed: () => {
                                      //                   _showPicker(context),
                                      //                 },
                                      //                 child: Text(
                                      //                   "Select image",
                                      //                   style: TextStyle(
                                      //                     color: Colors.black,
                                      //                   ),
                                      //                 ),
                                      //               )
                                      //             : Container(),
                                      //       )
                                      //     : Container(),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 6,
                  ),

//Distributor
                  Container(
                    child: _chosenValue == "Distributor"
                        ? Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Firm Name ',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        firmname = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Drug License No',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        drug_license_no = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'GST No/PAN No Of Firm',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        gst_pan_no_firm = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Address',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        address = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Area Name for Work',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        area_of_work = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primaryColor: Colors.redAccent,
                                        primaryColorDark: Colors.red,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 19),
                                            child: Text(
                                              "Have You any registration no",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItemdist = 'Yes';
                                                    id = 1;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style:
                                                    new TextStyle(fontSize: 17.0),
                                              ),
                                              Radio(
                                                value: 2,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItemdist = 'No';
                                                    id = 2;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style:
                                                    new TextStyle(fontSize: 17.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  radioButtonItemdist == "Yes"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText: 'Name of company',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  name_of_company = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                  radioButtonItemdist == "Yes"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText:
                                                  'Estimated Target of Business – (by amount in lacks)',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  target_of_business = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                  radioButtonItemdist == "No"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText:
                                                  'Estimated Target of Business – (by amount in lacks)',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  target_of_business = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText:
                                        'How Many Year of Experience in this Field',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        year_of_experience = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          )
                        : Container(),
                  ),

//stockist

                  Container(
                    child: _chosenValue == "Stockist"
                        ? Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Firm Name ',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        firmname = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Drug License No',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        drug_license_no = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'GST No/PAN No Of Firm',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        gst_pan_no_firm = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Theme(
                                data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: new TextField(
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
                                    hintText: 'Address',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) => {
                                    setState(
                                      () {
                                        address = value;
                                      },
                                    )
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                        primaryColor: Colors.redAccent,
                                        primaryColorDark: Colors.red,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 19),
                                            child: Text(
                                              "Have You any delearship no",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItemstockist = 'Yes';
                                                    id = 1;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style:
                                                    new TextStyle(fontSize: 17.0),
                                              ),
                                              Radio(
                                                value: 2,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItemstockist = 'No';
                                                    id = 2;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style:
                                                    new TextStyle(fontSize: 17.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Column(
                                children: [
                                  radioButtonItemstockist == "Yes"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText: 'Name of company',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  name_of_company = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                  radioButtonItemstockist == "Yes"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText:
                                                  'Estimated Target of Business – (by amount in lacks)',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  target_of_business = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                  radioButtonItemstockist == "No"
                                      ? Theme(
                                          data: ThemeData(
                                            primaryColor: Colors.redAccent,
                                            primaryColorDark: Colors.red,
                                          ),
                                          child: new TextField(
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
                                              hintText:
                                                  'Estimated Target of Business – (by amount in lacks)',
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onChanged: (value) => {
                                              setState(
                                                () {
                                                  target_of_business = value;
                                                },
                                              )
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //         onTap: _forgotDialogPopup,
                  //         child: Text(
                  //           "Forgot Password?",
                  //           style: TextStyle(
                  //             color: AppColors.forgotPasswordColor,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.appMainColor,
                  //   ),
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 50,
                  //   child: TextButton(
                  //     // onPressed: () {
                  //     //   loginUser(context);
                  //     //   ;
                  //     // },
                  //     child: Text(
                  //       "Submit",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Don't have an account?",
                  //       style: TextStyle(
                  //         color: AppColors.loginTextColor,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.pop(
                  //           context,
                  //         );
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             // builder: (context) => SignUpScreen(),
                  //           ),
                  //         );
                  //       },
                  //       child: Text(
                  //         "Sign up",
                  //         style: TextStyle(
                  //           color: AppColors.forgotPasswordColor,
                  //           fontSize: 15,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 80,
                  // ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.forgotLoginColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 180,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              registerUser(context);
                              ;
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: (() => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                ),
                              }),
                          child: Text(
                            "Already have an account? Click here to login",
                            style: TextStyle(
                              color: AppColors.forgotcreateColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final picker = ImagePicker();
    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image as File;
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image as File;
    });
  }
}
