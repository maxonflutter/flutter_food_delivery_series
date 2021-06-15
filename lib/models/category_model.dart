import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final String name;
  final Image image;

  Category({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];

  static List<Category> categories = [
    Category(
      name: 'Pizza',
      image: Image.asset(
        'assets/pizza.png',
      ),
    ),
    Category(
      name: 'Burger',
      image: Image.asset(
        'assets/burger.png',
      ),
    ),
    Category(
      name: 'Dessert',
      image: Image.asset(
        'assets/pancake.png',
      ),
    ),
    Category(
      name: 'Salad',
      image: Image.asset(
        'assets/avocado.png',
      ),
    ),
    Category(
      name: 'Drinks',
      image: Image.asset(
        'assets/juice.png',
      ),
    ),
  ];
}
