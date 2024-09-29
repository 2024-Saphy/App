class Product {
  int id;
  String deviceType;
  String name;
  String description;
  double price;
  int stock;
  Map<String, String> images; // 이미지 정보를 Map<String, String>으로 저장
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
      deviceType: json['deviceType'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      images: Map<String, String>.from(json['images']), // 직접 변환
      brand: json['brand'],
      color: json['color'],
      storage: json['storage'],
      grade: json['grade'],
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
