import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/models/menu_item_model.dart';

import 'category_model.dart';
import 'opening_hours_model.dart';
import 'product_model.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> tags;
  final List<Category> categories;
  final List<Product> products;
  final List<OpeningHours> openingHours;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.categories,
    required this.products,
    required this.openingHours,
    this.deliveryTime = 10,
    this.priceCategory = '\$',
    this.deliveryFee = 10,
    this.distance = 15,
  });

  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'],
      imageUrl: snap['imageUrl'],
      description: snap['description'],
      tags: (snap['tags'] as List).map(
        (tag) {
          return tag as String;
        },
      ).toList(),
      categories: (snap['categories'] as List).map(
        (category) {
          return Category.fromSnapshot(category);
        },
      ).toList(),
      products: (snap['products'] as List).map(
        (product) {
          return Product.fromSnapshot(product);
        },
      ).toList(),
      openingHours: (snap['openingHours'] as List).map(
        (openingHour) {
          return OpeningHours.fromSnapshot(openingHour);
        },
      ).toList(),
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      imageUrl,
      tags,
      categories,
      products,
      openingHours,
      deliveryTime,
      priceCategory,
      deliveryFee,
      distance,
    ];
  }
}
