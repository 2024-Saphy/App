class Product {
  int? productNo;
  String? productBrand;
  String? productName;
  String? productImageUrl;
  double? price;

  Product({
    this.productNo,
    this.productBrand,
    this.productName,
    this.productImageUrl,
    this.price,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productNo = int.parse(json['productNo']);
    productBrand = json['productBrand'];
    productName = json['productName'];
    productImageUrl = json['productImageUrl'];
    price = double.parse(json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productNo'] = productNo;
    data['productBrand'] = productBrand;
    data['productName'] = productName;
    data['productImageUrl'] = productImageUrl;
    data['price'] = price;
    return data;
  }
}
