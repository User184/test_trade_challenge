import 'dart:convert';
CatalogModel catalogModelFromJson(String str) => CatalogModel.fromJson(json.decode(str));
String catalogModelToJson(CatalogModel data) => json.encode(data.toJson());

class CatalogModel {
  CatalogModel({
      this.data,});

  CatalogModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.name, 
      this.description, 
      this.categoryId, 
      this.brandId, 
      this.sku, 
      this.url, 
      this.price, 
      this.productCover, 
      this.productVideo, 
      this.promoType,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    sku = json['sku'];
    url = json['url'];
    price = json['price'];
    if (json['product_cover'] != null) {
      productCover = [];
      json['product_cover'].forEach((v) {
        productCover.add(ProductCover.fromJson(v));
      });
    }
    productVideo = json['product_video'];
    promoType = json['promo_type'];
  }
  int id;
  String name;
  String description;
  dynamic categoryId;
  int brandId;
  String sku;
  String url;
  int price;
  List<ProductCover> productCover;
  dynamic productVideo;
  String promoType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['category_id'] = categoryId;
    map['brand_id'] = brandId;
    map['sku'] = sku;
    map['url'] = url;
    map['price'] = price;
    if (productCover != null) {
      map['product_cover'] = productCover.map((v) => v.toJson()).toList();
    }
    map['product_video'] = productVideo;
    map['promo_type'] = promoType;
    return map;
  }

}

ProductCover productCoverFromJson(String str) => ProductCover.fromJson(json.decode(str));
String productCoverToJson(ProductCover data) => json.encode(data.toJson());
class ProductCover {
  ProductCover({
      this.name, 
      this.url,});

  ProductCover.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String name;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}

class ErrorRequestCatalog extends CatalogModel {
  final String error;

  ErrorRequestCatalog({
    this.error,
  });
}
