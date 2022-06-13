import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;

  const Product({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromSnapshot(Map<String, dynamic> snap) {
    return Product(
      id: snap['id'].toString(),
      restaurantId: snap['restaurantId'],
      name: snap['name'],
      category: snap['category'],
      description: snap['description'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
    );
  }

  @override
  List<Object?> get props =>
      [id, restaurantId, name, category, description, imageUrl, price];
}
