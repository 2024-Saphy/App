class Product {
  int? id;
  String? brand;
  String? name;
  String? description;
  String? color;
  String? storage;
  String? grade;
  String? imageUrl;
  double? price;
  int? stock;

  Product({
    this.id,
    this.brand,
    this.name,
    this.description,
    this.color,
    this.storage,
    this.grade,
    this.imageUrl,
    this.price,
    this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    brand = json['brand'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
    storage = json['storage'];
    grade = json['grade'];
    imageUrl = json['imageUrl'];
    price = double.parse(json['price']);
    stock = int.parse(json['stock']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['brand'] = brand;
    data['name'] = name;
    data['description'] = description;
    data['color'] = color;
    data['storage'] = storage;
    data['grade'] = grade;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['stock'] = stock;
    return data;
  }
}
