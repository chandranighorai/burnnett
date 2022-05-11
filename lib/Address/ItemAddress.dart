import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util/AppColors.dart';
import '../util/Consts.dart';
import 'AddressModel.dart';

class ItemAddress extends StatefulWidget {
  final Function(AddressModel itemAddress) notifyParent;
  final AddressModel addressModel;
  final List<AddressModel> mAddressList;

  const ItemAddress(
      {Key key, this.addressModel, this.mAddressList, this.notifyParent})
      : super(key: key);
  @override
  _ItemAddressState createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress> {
  AddressModel itemAddress;
  List<AddressModel> _mAddressList;
  String address;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemAddress = widget.addressModel;
    _mAddressList = widget.mAddressList;
    address = "";
    if (itemAddress.name != null && itemAddress.name != "") {
      address += itemAddress.name;
    }
    if (itemAddress.flatHouseFloorBuilding != null &&
        itemAddress.flatHouseFloorBuilding != "") {
      if (address == "") {
        address += "" + itemAddress.flatHouseFloorBuilding;
      } else {
        address += "\n" + itemAddress.flatHouseFloorBuilding;
      }
    }
    if (itemAddress.locality != null && itemAddress.locality != "") {
      address += " " + itemAddress.locality;
    }
    if (itemAddress.landmark != null && itemAddress.landmark != "") {
      address += "\n" + itemAddress.landmark;
    }
    if (itemAddress.city != null && itemAddress.city != "") {
      address += " " + itemAddress.city;
    }
    if (itemAddress.pincode != null && itemAddress.pincode != "") {
      address += " - " + itemAddress.pincode;
    }
  }

  _itemSetDefault(bool isDefault) async {
    // setState(() {
    //   itemAddress.defaultBilling = isDefault ? "0" : "1";
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString('user_id');
    var requestParam = "?";
    requestParam += "user_id=" + user_id;
    requestParam += "&address_id=" + widget.addressModel.id;

    final http.Response response = await http.get(
      Uri.parse(Consts.updateDefaultAddress + requestParam),
    );
    print(Consts.updateDefaultAddress + requestParam);
    print("updateDefaultAddress response ${response.body}");
    widget.notifyParent(itemAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.checkoutAddDeleiverColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "$address",
                    softWrap: true,
                    style: TextStyle(
                      color: AppColors.checkoutAddressColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    debugPrint("Mark as default.");
                    _itemSetDefault(
                      itemAddress.defaultBilling == "1" ? true : false,
                    );
                  },
                  child: Container(
                    width: 50,
                    child: Icon(
                      Icons.check_circle,
                      size: 25,
                      color: itemAddress.defaultBilling == "1"
                          ? AppColors.checkoutAddDeleiverColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
