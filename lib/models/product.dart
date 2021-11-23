import 'dart:convert';

class Product {
  String? id;
  String name;
  String description;
  String imageUrl;

  Product({
    this.id,
    required this.description,
    required this.name,
    required this.imageUrl,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "image_url": imageUrl,
      };
}
