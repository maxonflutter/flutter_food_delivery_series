import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String name;
  final String imageUrl;
  final List<String> tags;
  // final List<MenuItem> menuItems; // TODO: Create MenuItem class
  final int deliveryTime;
  final double deliveryFee;
  final double distance; // TODO: Calculate distance between user and restaurant

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.tags,
    // required this.menuItems,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
  });

  @override
  List<Object> get props {
    return [
      name,
      imageUrl,
      tags,
      // menuItems,
      deliveryTime,
      deliveryFee,
      distance,
    ];
  }

  static List<Restaurant> restaurants = [
    Restaurant(
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://images.unsplash.com/photo-1479044769763-c28e05b5baa5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      tags: ['Italian', 'Dessert', 'Ice Cream'],
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://images.unsplash.com/photo-1479044769763-c28e05b5baa5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      tags: ['Italian', 'Dessert', 'Ice Cream'],
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://images.unsplash.com/photo-1479044769763-c28e05b5baa5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      tags: ['Italian', 'Dessert', 'Ice Cream'],
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      name: 'Golden Ice Gelato Artigianale',
      imageUrl:
          'https://images.unsplash.com/photo-1479044769763-c28e05b5baa5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      tags: ['Italian', 'Dessert', 'Ice Cream'],
      deliveryTime: 30,
      deliveryFee: 2.99,
      distance: 0.1,
    )
  ];
}
