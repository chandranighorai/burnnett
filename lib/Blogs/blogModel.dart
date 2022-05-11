class BlogModel {
  List<BlogData> blogdata;
  String code;
  String status;
  String message;

  BlogModel({this.blogdata, this.code, this.status, this.message});

  BlogModel.fromJson(Map<String, dynamic> json) {
    if (json['respData'] != null) {
      blogdata = new List<BlogData>();
      json['respData'].forEach((v) {
        blogdata.add(new BlogData.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogdata != null) {
      data['respData'] = this.blogdata.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class BlogData {
  String blogId;
  String blogTitle;
  String blogSlug;
  String categoryId;
  String image;
  String description;
  String metaTitle;
  String metaKeyword;
  String metaDescription;
  String addedBy;
  String addedDate;
  String status;

  BlogData(
      {this.blogId,
      this.blogTitle,
      this.blogSlug,
      this.categoryId,
      this.image,
      this.description,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.addedBy,
      this.addedDate,
      this.status});

  BlogData.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'];
    blogTitle = json['blog_title'];
    blogSlug = json['blog_slug'];
    categoryId = json['category_id'];
    image = json['image'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    addedBy = json['added_by'];
    addedDate = json['added_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blog_id'] = this.blogId;
    data['blog_title'] = this.blogTitle;
    data['blog_slug'] = this.blogSlug;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['description'] = this.description;
    data['meta_title'] = this.metaTitle;
    data['meta_keyword'] = this.metaKeyword;
    data['meta_description'] = this.metaDescription;
    data['added_by'] = this.addedBy;
    data['added_date'] = this.addedDate;
    data['status'] = this.status;
    return data;
  }
}
