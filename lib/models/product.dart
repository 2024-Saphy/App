class Product {
  int id;
  String deviceType;
  String name;
  String description;
  int price;
  int stock;
  List<ImageInfo> images;

  Product({
    required this.id,
    required this.deviceType,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      deviceType: json['deviceType'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      images: List<ImageInfo>.from(
          json['images'].map((image) => ImageInfo.fromJson(image))),
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
      'images': images.map((image) => image.toJson()).toList(),
    };
  }
}

class ImageInfo {
  String name;
  String url;

  ImageInfo({
    required this.name,
    required this.url,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
