import 'dart:convert';

class Product {
  final String productName;
  final String authorName;
  final String publisher;
  final String yearPublished;
  final String description;
  final double price;
  final double quantity;
  final String genre;
  final String category;
  final List<String> images;
  final String? id;

  Product({
    required this.productName,
    required this.authorName,
    required this.publisher,
    required this.yearPublished,
    required this.description,
    required this.price,
    required this.quantity,
    required this.genre,
    required this.category,
    required this.images,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'authorName': authorName,
      'publisher': publisher,
      'yearPublished': yearPublished,
      'description': description,
      'price': price,
      'quantity': quantity,
      'genre': genre,
      'category': category,
      'images': images,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? '',
      authorName: map['authorName'] ?? '',
      publisher: map['publisher'] ?? '',
      yearPublished: map['yearPublished'] ?? '',
      description: map['description'] ?? '',
      price: map['price'].toDouble() ?? 0.0,
      quantity: map['quantity'].toDouble() ?? 0.0,
      genre: map['genre'] ?? '',
      category: map['category'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
