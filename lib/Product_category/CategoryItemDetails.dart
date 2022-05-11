import 'package:burnett/ProductDetails/ProductDet.dart';
import 'package:burnett/Product_category/ProductbycategoryDetails.dart';
import 'package:flutter/material.dart';

class CategoryItemDetails extends StatefulWidget {
  final Productdata categorydata;
  final ProductAttribute categorydata1;
  const CategoryItemDetails(
      {Key key,
      this.categorydata,
      this.categorydata1,
      List<ProductAttribute> item})
      : super(key: key);
  @override
  _CategoryItemDetailsState createState() => _CategoryItemDetailsState();
}

class _CategoryItemDetailsState extends State<CategoryItemDetails> {
  String seleType = "", selectpType = "";
  double selectPrice;
  bool isPrice, isSelect;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seleType = "";
    isPrice = false;
    isSelect = false;
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 140;
    Productdata categorydata = widget.categorydata;
    ProductAttribute productAttribute = widget.categorydata1;
    print("Categorydata..." + categorydata.productAttribute.isEmpty.toString());
    print("Categorydata..." + productAttribute.toString());

    if (!isPrice) {
      if (!categorydata.productAttribute.isEmpty) {
        selectPrice = double.parse(
            categorydata.productAttribute[0].productPrice.toString());
        seleType = categorydata.productAttribute[0].name;
        selectpType = categorydata.productAttribute[0].name;
        containerWidth = 190;
        isSelect = true;
        print(seleType);
      } else {
        containerWidth = 140;
        //print("Categorydata..." + categorydata.productPrice.toString());
        if (categorydata.productPrice.toString() == "null") {
          selectPrice = 0.0;
        } else {
          selectPrice = double.parse(categorydata.productPrice);
        }
        print('seleType..' + selectPrice.toString());
      }
    } else {
      containerWidth = 190;
    }
    initState() {
      super.initState();
    }

    // selcetml() {}
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: containerWidth,
              decoration: BoxDecoration(
                // border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(9),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 12.0, bottom: 12, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product Name",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          categorydata.productTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categorydata.productAttribute.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 12, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Potency",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              selectPrice == 0.0
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19),
                                      child: Container(
                                        child: DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          value: seleType,
                                          // underline: Container(
                                          // underline can be styled as well
                                          // height: 4.0,
                                          // color: Colors.blue,
                                          // ), // this removes underline
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.black,
                                            size: 40,
                                          ),
                                          iconEnabledColor: Colors.blue,
                                          items: categorydata.productAttribute
                                              .map<DropdownMenuItem<String>>(
                                                  (ProductAttribute value) {
                                            return DropdownMenuItem<String>(
                                              value: value.name,
                                              child: Text(
                                                value.name,
                                                style: new TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          hint: new Text(
                                            "Select unit",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              seleType = value;
                                              selectPrice = double.parse(
                                                  categorydata
                                                      .productAttribute[0]
                                                      .productPrice);
                                              isPrice = true;
                                            });
                                            categorydata.productAttribute
                                                .map((ProductAttribute map) {
                                              print(
                                                  "map name...0.." + map.name);
                                              print("map name...1.." + value);

                                              if (map.name == value) {
                                                setState(() {
                                                  selectPrice = double.parse(map
                                                      .productPrice
                                                      .toString());
                                                  selectpType = value;
                                                  isSelect = true;
                                                });
                                              }
                                              print("map name...1.." +
                                                  selectPrice.toString());
                                              print("map name...1.." +
                                                  selectpType.toString());
                                              print("map name...1.." +
                                                  isSelect.toString());

                                              // print(map.name +
                                              //     " " +
                                              //     selectpType +
                                              //     " " +
                                              //     selectPrice.toString());
                                            }).toList();
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          //             ]),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 2.0, bottom: 12, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        categorydata.productAttribute.isEmpty
                            ? selectPrice == 0.0
                                ? SizedBox()
                                : Text(
                                    "\u20B9 " + categorydata.productPrice,
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                            : Container(
                                child: Text(
                                  "\u20B9 " + selectPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      // border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            // color: Colors.grey,
                            // offset: Offset.zero,
                            // blurRadius: 6.0,
                            // spreadRadius: 0.0,
                            ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: (() => {
                            print("CatId..." + categorydata.productId),
                            print("CatId..." + selectpType),
                            print("CatId..." + isSelect.toString()),
                            print("CatId..." + selectPrice.toString()),
                            selectPrice == 0.0
                                ? SizedBox()
                                : Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDet(
                                        categoryID: categorydata.productId,
                                        seleType: selectpType,
                                        isSelect: isSelect,
                                        selectPrice: selectPrice,
                                      ),
                                    ),
                                  ),
                            print('selectpType'),
                            print(selectpType),
                          }),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }
}
