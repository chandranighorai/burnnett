import 'package:flutter/cupertino.dart';

class ProductDataModel {
  String status;
  String message;
  List<Productdata> productdata;

  ProductDataModel({this.status, this.message, this.productdata});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['productdata'] != null) {
      productdata = new List<Productdata>();
      json['productdata'].forEach((v) {
        // debugPrint("$v");
        productdata.add(new Productdata.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   debugPrint("$this.message");
  //   if (this.productdata != null) {
  //     data['productdata'] = this.productdata.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Productdata {
  String productId;
  String productType;
  String productCode;
  String uniqueKey;
  String productTitle;
  String productDescription;
  String categoryId;
  String brandId;
  String gstId;
  String productPrice;
  String productRegularPrice;
  Null productUnit;
  String productBatchNo;
  String productQuantityInfo;
  String productImage;
  String stockCount;
  String status;
  String metaTitle;
  String metaKeyword;
  String metaDescription;
  String addedDate;
  // List<BrandDetails> brandDetails;
  // List<CatDetails> catDetails;
  String productcatimg;
  // List<String> galleryImages;
  // List<ProductAttribute> productAttribute;

  Productdata(
      {this.productId,
      this.productType,
      this.productCode,
      this.uniqueKey,
      this.productTitle,
      this.productDescription,
      this.categoryId,
      this.brandId,
      this.gstId,
      this.productPrice,
      this.productRegularPrice,
      this.productUnit,
      this.productBatchNo,
      this.productQuantityInfo,
      this.productImage,
      this.stockCount,
      this.status,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.addedDate,
      // this.brandDetails,
      // this.catDetails,
      this.productcatimg,
      // this.galleryImages,
      // this.productAttribute
      });

  Productdata.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productCode = json['product_code'];
    uniqueKey = json['unique_key'];
    productTitle = json['product_title'];
    productDescription = json['product_description'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    gstId = json['gst_id'];
    productPrice = json['product_price'];
    productRegularPrice = json['product_regular_price'];
    productUnit = json['product_unit'];
    productBatchNo = json['product_batch_no'];
    productQuantityInfo = json['product_quantity_info'];
    productImage = json['product_image'];
    stockCount = json['stock_count'];
    status = json['status'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    addedDate = json['added_date'];
    // if (json['brand_details'] != null) {
    //   brandDetails = new List<BrandDetails>();
    //   json['brand_details'].forEach((v) {
    //     brandDetails.add(new BrandDetails.fromJson(v));
    //   });
    // }
    // if (json['cat_details'] != null) {
    //   catDetails = new List<CatDetails>();
    //   json['cat_details'].forEach((v) {
    //     catDetails.add(new CatDetails.fromJson(v));
    //   });
    // }
    productcatimg = json['productcatimg'];
    // galleryImages = json['gallery_images'].cast<String>();
    // if (json['product_attribute'] != null) {
    //   productAttribute = new List<ProductAttribute>();
    //   json['product_attribute'].forEach((v) {
    //     productAttribute.add(new ProductAttribute.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['product_code'] = this.productCode;
    data['unique_key'] = this.uniqueKey;
    data['product_title'] = this.productTitle;
    data['product_description'] = this.productDescription;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['gst_id'] = this.gstId;
    data['product_price'] = this.productPrice;
    data['product_regular_price'] = this.productRegularPrice;
    data['product_unit'] = this.productUnit;
    data['product_batch_no'] = this.productBatchNo;
    data['product_quantity_info'] = this.productQuantityInfo;
    data['product_image'] = this.productImage;
    data['stock_count'] = this.stockCount;
    data['status'] = this.status;
    data['meta_title'] = this.metaTitle;
    data['meta_keyword'] = this.metaKeyword;
    data['meta_description'] = this.metaDescription;
    data['added_date'] = this.addedDate;
    // if (this.brandDetails != null) {
    //   data['brand_details'] = this.brandDetails.map((v) => v.toJson()).toList();
    // }
    // if (this.catDetails != null) {
    //   data['cat_details'] = this.catDetails.map((v) => v.toJson()).toList();
    // }
    // data['productcatimg'] = this.productcatimg;
    // data['gallery_images'] = this.galleryImages;
    // if (this.productAttribute != null) {
    //   data['product_attribute'] =
    //       this.productAttribute.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class BrandDetails {
//   String brandId;
//   String brandName;
//   String brandDescription;

//   BrandDetails({this.brandId, this.brandName, this.brandDescription});

//   BrandDetails.fromJson(Map<String, dynamic> json) {
//     brandId = json['brand_id'];
//     brandName = json['brand_name'];
//     brandDescription = json['brand_description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['brand_id'] = this.brandId;
//     data['brand_name'] = this.brandName;
//     data['brand_description'] = this.brandDescription;
//     return data;
//   }
// }

// class CatDetails {
//   String categoryId;
//   String catName;
//   String catDescription;

//   CatDetails({this.categoryId, this.catName, this.catDescription});

//   CatDetails.fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     catName = json['cat_name'];
//     catDescription = json['cat_description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category_id'] = this.categoryId;
//     data['cat_name'] = this.catName;
//     data['cat_description'] = this.catDescription;
//     return data;
//   }
// }

// class ProductAttribute {
//   String variableAttributeId;
//   String productId;
//   String attributeId;
//   String variationId;
//   String productPrice;
//   String productRegularPrice;
//   String name;

//   ProductAttribute(
//       {this.variableAttributeId,
//       this.productId,
//       this.attributeId,
//       this.variationId,
//       this.productPrice,
//       this.productRegularPrice,
//       this.name});

//   ProductAttribute.fromJson(Map<String, dynamic> json) {
//     variableAttributeId = json['variable_attribute_id'];
//     productId = json['product_id'];
//     attributeId = json['attribute_id'];
//     variationId = json['variation_id'];
//     productPrice = json['product_price'];
//     productRegularPrice = json['product_regular_price'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['variable_attribute_id'] = this.variableAttributeId;
//     data['product_id'] = this.productId;
//     data['attribute_id'] = this.attributeId;
//     data['variation_id'] = this.variationId;
//     data['product_price'] = this.productPrice;
//     data['product_regular_price'] = this.productRegularPrice;
//     data['name'] = this.name;
//     return data;
//   }
// }
