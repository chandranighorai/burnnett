class ProductDetailsModel {
  String status;
  String message;
  List<Productdata> productdata;

  ProductDetailsModel({this.status, this.message, this.productdata});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['productdata'] != null) {
      productdata = new List<Productdata>();
      json['productdata'].forEach((v) {
        // print(v);
        productdata.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productdata != null) {
      data['productdata'] = this.productdata.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
  String productUnit;
  String productBatchNo;
  String productQuantityInfo;
  String productImage;
  String stockCount;
  String status;
  String metaTitle;
  String metaKeyword;
  String metaDescription;
  // String addedDate;
  // List<BrandDetails> brandDetails;
  // List<CatDetails> catDetails;
  String productcatimg;
  // List<String> galleryImages;
  List<ProductAttribute> productAttribute;
  List<RelatedProductList> relatedProductList;
  List<ProductReview> productReview;
  String baseUrl;
  String shareUrl;

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
      // this.addedDate,
      // this.brandDetails,
      // this.catDetails,
      this.productcatimg,
      // this.galleryImages,
      this.productAttribute,
      this.relatedProductList,
      this.productReview,
      this.baseUrl,
      this.shareUrl});

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
    // addedDate = json['added_date'];
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
    if (json['product_attribute'] != null) {
      productAttribute = new List<ProductAttribute>();
      json['product_attribute'].forEach((v) {
        print(v);
        productAttribute.add(new ProductAttribute.fromJson(v));
      });
    }
    if (json['related_product_list'] != null) {
      relatedProductList = new List<RelatedProductList>();
      json['related_product_list'].forEach((v) {
        relatedProductList.add(new RelatedProductList.fromJson(v));
      });
    }
    if (json['product_review'] != null) {
      productReview = new List<ProductReview>();
      json['product_review'].forEach((v) {
        productReview.add(new ProductReview.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    shareUrl = json["share_url"];
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
    // data['added_date'] = this.addedDate;
    // if (this.brandDetails != null) {
    //   data['brand_details'] = this.brandDetails.map((v) => v.toJson()).toList();
    // }
    // if (this.catDetails != null) {
    //   data['cat_details'] = this.catDetails.map((v) => v.toJson()).toList();
    // }
    data['productcatimg'] = this.productcatimg;
    // data['gallery_images'] = this.galleryImages;
    if (this.productAttribute != null) {
      data['product_attribute'] = this.productAttribute.map((v) => v).toList();
    }
    if (this.relatedProductList != null) {
      data['related_product_list'] =
          this.relatedProductList.map((v) => v.toJson()).toList();
    }
    if (this.productReview != null) {
      data['product_review'] =
          this.productReview.map((v) => v.toJson()).toList();
    }
    data['base_url'] = this.baseUrl;
    data['share_url'] = this.shareUrl;
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

class ProductAttribute {
  String variableAttributeId;
  String productId;
  String attributeId;
  String variationId;
  String productPrice;
  String productRegularPrice;
  String name;

  ProductAttribute(
      {this.variableAttributeId,
      this.productId,
      this.attributeId,
      this.variationId,
      this.productPrice,
      this.productRegularPrice,
      this.name});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    variableAttributeId = json['variable_attribute_id'];
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    variationId = json['variation_id'];
    productPrice = json['product_price'];
    productRegularPrice = json['product_regular_price'];
    name = json['name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['variable_attribute_id'] = this.variableAttributeId;
  //   data['product_id'] = this.productId;
  //   data['attribute_id'] = this.attributeId;
  //   data['variation_id'] = this.variationId;
  //   data['product_price'] = this.productPrice;
  //   data['product_regular_price'] = this.productRegularPrice;
  //   data['name'] = this.name;
  //   return data;
  // }
}

class ProductReview {
  String reviewId;
  String productId;
  String userId;
  String name;
  String emailId;
  String message;
  String dateAdded;

  ProductReview(
      {this.reviewId,
      this.productId,
      this.userId,
      this.name,
      this.emailId,
      this.message,
      this.dateAdded});

  ProductReview.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    productId = json['product_id'];
    userId = json['user_id'];
    name = json['name'];
    emailId = json['email_id'];
    message = json['message'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['message'] = this.message;
    data['date_added'] = this.dateAdded;
    return data;
  }
}

class RelatedProductList {
  String productId;
  String productType;
  String productCode;
  String uniqueKey;
  String productTitle;
  String productComponent;
  String productDescription;
  String infoForDoctor;
  String indicationEnglishText;
  String indicationBengaliText;
  String indicationHindiText;
  String indicationEnglishImg;
  String indicationBengaliImg;
  String indicationHindiImg;
  String dose;
  String doseHindi;
  String doseBengali;
  String categoryId;
  String brandId;
  String gstId;
  String productPrice;
  String productRegularPrice;
  Null productUnit;
  Null productBatchNo;
  String productQuantityInfo;
  String productImage;
  String stockCount;
  String status;
  String metaTitle;
  String metaKeyword;
  String metaDescription;
  String addedDate;
  String weight;
  String length;
  String breadth;
  String height;
  String altForProductImage;
  String altForEngIndicationImage;
  String altForHindiIndicationImage;
  String altForBenIndicationImage;
  String catId;
  String name;
  String uniqueName;
  String categoryImage;
  String description;
  String parentId;
  String catPriority;
  String dateAdded;

  RelatedProductList(
      {this.productId,
      this.productType,
      this.productCode,
      this.uniqueKey,
      this.productTitle,
      this.productComponent,
      this.productDescription,
      this.infoForDoctor,
      this.indicationEnglishText,
      this.indicationBengaliText,
      this.indicationHindiText,
      this.indicationEnglishImg,
      this.indicationBengaliImg,
      this.indicationHindiImg,
      this.dose,
      this.doseHindi,
      this.doseBengali,
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
      this.weight,
      this.length,
      this.breadth,
      this.height,
      this.altForProductImage,
      this.altForEngIndicationImage,
      this.altForHindiIndicationImage,
      this.altForBenIndicationImage,
      this.catId,
      this.name,
      this.uniqueName,
      this.categoryImage,
      this.description,
      this.parentId,
      this.catPriority,
      this.dateAdded});

  RelatedProductList.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    productCode = json['product_code'];
    uniqueKey = json['unique_key'];
    productTitle = json['product_title'];
    productComponent = json['product_component'];
    productDescription = json['product_description'];
    infoForDoctor = json['info_for_doctor'];
    indicationEnglishText = json['indication_english_text'];
    indicationBengaliText = json['indication_bengali_text'];
    indicationHindiText = json['indication_hindi_text'];
    indicationEnglishImg = json['indication_english_img'];
    indicationBengaliImg = json['indication_bengali_img'];
    indicationHindiImg = json['indication_hindi_img'];
    dose = json['dose'];
    doseHindi = json['dose_hindi'];
    doseBengali = json['dose_bengali'];
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
    weight = json['weight'];
    length = json['length'];
    breadth = json['breadth'];
    height = json['height'];
    altForProductImage = json['alt_for_product_image'];
    altForEngIndicationImage = json['alt_for_eng_indication_image'];
    altForHindiIndicationImage = json['alt_for_hindi_indication_image'];
    altForBenIndicationImage = json['alt_for_ben_indication_image'];
    catId = json['cat_id'];
    name = json['name'];
    uniqueName = json['unique_name'];
    categoryImage = json['category_image'];
    description = json['description'];
    parentId = json['parent_id'];
    catPriority = json['cat_priority'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['product_code'] = this.productCode;
    data['unique_key'] = this.uniqueKey;
    data['product_title'] = this.productTitle;
    data['product_component'] = this.productComponent;
    data['product_description'] = this.productDescription;
    data['info_for_doctor'] = this.infoForDoctor;
    data['indication_english_text'] = this.indicationEnglishText;
    data['indication_bengali_text'] = this.indicationBengaliText;
    data['indication_hindi_text'] = this.indicationHindiText;
    data['indication_english_img'] = this.indicationEnglishImg;
    data['indication_bengali_img'] = this.indicationBengaliImg;
    data['indication_hindi_img'] = this.indicationHindiImg;
    data['dose'] = this.dose;
    data['dose_hindi'] = this.doseHindi;
    data['dose_bengali'] = this.doseBengali;
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
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['breadth'] = this.breadth;
    data['height'] = this.height;
    data['alt_for_product_image'] = this.altForProductImage;
    data['alt_for_eng_indication_image'] = this.altForEngIndicationImage;
    data['alt_for_hindi_indication_image'] = this.altForHindiIndicationImage;
    data['alt_for_ben_indication_image'] = this.altForBenIndicationImage;
    data['cat_id'] = this.catId;
    data['name'] = this.name;
    data['unique_name'] = this.uniqueName;
    data['category_image'] = this.categoryImage;
    data['description'] = this.description;
    data['parent_id'] = this.parentId;
    data['cat_priority'] = this.catPriority;
    data['date_added'] = this.dateAdded;
    return data;
  }
}
