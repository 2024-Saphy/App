class Product {
  int id;
  String deviceType;
  String name;
  String description;
  int price;
  int stock;
  List<ImageModel> images;
  String brand;
  String color;
  String storage;
  String grade;

  Product({
    required this.id,
    required this.deviceType,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
    required this.brand,
    required this.color,
    required this.storage,
    required this.grade,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      deviceType: json['deviceType'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'],
      stock: json['stock'] ?? "",
      images: (json['images'] as List)
          .map((item) => ImageModel.fromJson(item))
          .toList(),
      brand: json['brand'] ?? "",
      color: json['color'] ?? "",
      storage: json['storage'] ?? "",
      grade: json['grade'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceType': deviceType,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'images': images, // 직접 저장
      'brand': brand,
      'color': color,
      'storage': storage,
      'grade': grade,
    };
  }
}

class ImageModel {
  final String name;
  final String url;

  ImageModel({required this.name, required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
