class OrderDetails {
  String status;
  String message;
  List<OrderData> orderData;

  OrderDetails({this.status, this.message, this.orderData});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['order_data'] != null) {
      orderData = new List<OrderData>();
      json['order_data'].forEach((v) {
        orderData.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderData != null) {
      data['order_data'] = this.orderData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  String orderId;
  String userId;
  String orderUniqueId;
  String orderTotalValue;
  String orderSubtotalValue;
  Null userDiscount;
  String couponDiscount;
  String couponId;
  Null payWalletAmount;
  Null orderCgstValue;
  Null orderSgstValue;
  String shippingCost;
  String date;
  Null memberId;
  String billingName;
  String billingEmail;
  String billingPhone;
  String billingFlatHouseFloorBuilding;
  String billingLocality;
  String billingLandmark;
  String billingCity;
  String billingPincode;
  String billingState;
  String billingCountry;
  String shippingName;
  String shippingPhone;
  String shippingFlatHouseFloorBuilding;
  String shippingLocality;
  String shippingLandmark;
  String shippingCity;
  String shippingPincode;
  String shippingState;
  String shippingCountry;
  String shippingAddressType;
  String orderStatus;
  String orderStatusText;
  String orderCurrencySign;
  String orderCurrency;
  String awbno;
  String paymentStatus;
  String paymentType;
  String paymentMethod;
  Null txnId;
  String shippingAddressId;
  String billingAddressId;
  Null uploadPrescription;
  String orderDateStr;
  MyOrderDetails myOrderDetails;

  OrderData(
      {this.orderId,
      this.userId,
      this.orderUniqueId,
      this.orderTotalValue,
      this.orderSubtotalValue,
      this.userDiscount,
      this.couponDiscount,
      this.couponId,
      this.payWalletAmount,
      this.orderCgstValue,
      this.orderSgstValue,
      this.shippingCost,
      this.date,
      this.memberId,
      this.billingName,
      this.billingEmail,
      this.billingPhone,
      this.billingFlatHouseFloorBuilding,
      this.billingLocality,
      this.billingLandmark,
      this.billingCity,
      this.billingPincode,
      this.billingState,
      this.billingCountry,
      this.shippingName,
      this.shippingPhone,
      this.shippingFlatHouseFloorBuilding,
      this.shippingLocality,
      this.shippingLandmark,
      this.shippingCity,
      this.shippingPincode,
      this.shippingState,
      this.shippingCountry,
      this.shippingAddressType,
      this.orderStatus,
      this.orderStatusText,
      this.orderCurrencySign,
      this.orderCurrency,
      this.awbno,
      this.paymentStatus,
      this.paymentType,
      this.paymentMethod,
      this.txnId,
      this.shippingAddressId,
      this.billingAddressId,
      this.uploadPrescription,
      this.orderDateStr,
      this.myOrderDetails});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    orderUniqueId = json['order_unique_id'];
    orderTotalValue = json['order_total_value'];
    orderSubtotalValue = json['order_subtotal_value'];
    userDiscount = json['user_discount'];
    couponDiscount = json['coupon_discount'];
    couponId = json['coupon_id'];
    payWalletAmount = json['pay_wallet_amount'];
    orderCgstValue = json['order_cgst_value'];
    orderSgstValue = json['order_sgst_value'];
    shippingCost = json['shipping_cost'];
    date = json['date'];
    memberId = json['member_id'];
    billingName = json['billing_name'];
    billingEmail = json['billing_email'];
    billingPhone = json['billing_phone'];
    billingFlatHouseFloorBuilding = json['billing_flat_house_floor_building'];
    billingLocality = json['billing_locality'];
    billingLandmark = json['billing_landmark'];
    billingCity = json['billing_city'];
    billingPincode = json['billing_pincode'];
    billingState = json['billing_state'];
    billingCountry = json['billing_country'];
    shippingName = json['shipping_name'];
    shippingPhone = json['shipping_phone'];
    shippingFlatHouseFloorBuilding = json['shipping_flat_house_floor_building'];
    shippingLocality = json['shipping_locality'];
    shippingLandmark = json['shipping_landmark'];
    shippingCity = json['shipping_city'];
    shippingPincode = json['shipping_pincode'];
    shippingState = json['shipping_state'];
    shippingCountry = json['shipping_country'];
    shippingAddressType = json['shipping_address_type'];
    orderStatus = json['order_status'];
    orderStatusText = json['order_status_text'];
    orderCurrencySign = json['order_currency_sign'];
    orderCurrency = json['order_currency'];
    awbno = json['awbno'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    txnId = json['txn_id'];
    shippingAddressId = json['shipping_address_id'];
    billingAddressId = json['billing_address_id'];
    uploadPrescription = json['upload_prescription'];
    orderDateStr = json['order_date_str'];
    myOrderDetails = json['my_order_details'] != null
        ? new MyOrderDetails.fromJson(json['my_order_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['order_unique_id'] = this.orderUniqueId;
    data['order_total_value'] = this.orderTotalValue;
    data['order_subtotal_value'] = this.orderSubtotalValue;
    data['user_discount'] = this.userDiscount;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_id'] = this.couponId;
    data['pay_wallet_amount'] = this.payWalletAmount;
    data['order_cgst_value'] = this.orderCgstValue;
    data['order_sgst_value'] = this.orderSgstValue;
    data['shipping_cost'] = this.shippingCost;
    data['date'] = this.date;
    data['member_id'] = this.memberId;
    data['billing_name'] = this.billingName;
    data['billing_email'] = this.billingEmail;
    data['billing_phone'] = this.billingPhone;
    data['billing_flat_house_floor_building'] =
        this.billingFlatHouseFloorBuilding;
    data['billing_locality'] = this.billingLocality;
    data['billing_landmark'] = this.billingLandmark;
    data['billing_city'] = this.billingCity;
    data['billing_pincode'] = this.billingPincode;
    data['billing_state'] = this.billingState;
    data['billing_country'] = this.billingCountry;
    data['shipping_name'] = this.shippingName;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_flat_house_floor_building'] =
        this.shippingFlatHouseFloorBuilding;
    data['shipping_locality'] = this.shippingLocality;
    data['shipping_landmark'] = this.shippingLandmark;
    data['shipping_city'] = this.shippingCity;
    data['shipping_pincode'] = this.shippingPincode;
    data['shipping_state'] = this.shippingState;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_address_type'] = this.shippingAddressType;
    data['order_status'] = this.orderStatus;
    data['order_status_text'] = this.orderStatusText;
    data['order_currency_sign'] = this.orderCurrencySign;
    data['order_currency'] = this.orderCurrency;
    data['awbno'] = this.awbno;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['payment_method'] = this.paymentMethod;
    data['txn_id'] = this.txnId;
    data['shipping_address_id'] = this.shippingAddressId;
    data['billing_address_id'] = this.billingAddressId;
    data['upload_prescription'] = this.uploadPrescription;
    data['order_date_str'] = this.orderDateStr;
    if (this.myOrderDetails != null) {
      data['my_order_details'] = this.myOrderDetails.toJson();
    }
    return data;
  }
}

class MyOrderDetails {
  String orderDetailId;
  String orderId;
  String productId;
  String quantity;
  String price;
  String cgst;
  String cgstTitle;
  String sgst;
  String sgstTitle;
  String isManaged;
  String productTitle;
  String productImage;

  MyOrderDetails(
      {this.orderDetailId,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.cgst,
      this.cgstTitle,
      this.sgst,
      this.sgstTitle,
      this.isManaged,
      this.productTitle,
      this.productImage});

  MyOrderDetails.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['order_detail_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    cgst = json['cgst'];
    cgstTitle = json['cgst_title'];
    sgst = json['sgst'];
    sgstTitle = json['sgst_title'];
    isManaged = json['is_managed'];
    productTitle = json['product_title'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_detail_id'] = this.orderDetailId;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['cgst'] = this.cgst;
    data['cgst_title'] = this.cgstTitle;
    data['sgst'] = this.sgst;
    data['sgst_title'] = this.sgstTitle;
    data['is_managed'] = this.isManaged;
    data['product_title'] = this.productTitle;
    data['product_image'] = this.productImage;
    return data;
  }
}
