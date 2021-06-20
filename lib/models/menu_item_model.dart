import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String category;
  final String description;
  final double price;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        name,
        category,
        description,
        price,
      ];

  static List<MenuItem> menuItems = [
    MenuItem(
      id: 1,
      restaurantId: 1,
      name: 'Margherita',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    MenuItem(
      id: 2,
      restaurantId: 1,
      name: '4 Formaggi',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    MenuItem(
      id: 3,
      restaurantId: 1,
      name: 'Baviera',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    MenuItem(
      id: 4,
      restaurantId: 1,
      name: 'Baviera',
      category: 'Pizza',
      description: 'Tomatoes, mozzarella, basil',
      price: 4.99,
    ),
    MenuItem(
      id: 5,
      restaurantId: 1,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    MenuItem(
      id: 6,
      restaurantId: 1,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    MenuItem(
      id: 7,
      restaurantId: 2,
      name: 'Coca Cola',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    MenuItem(
      id: 8,
      restaurantId: 3,
      name: 'Water',
      category: 'Drink',
      description: 'A fresh drink',
      price: 1.99,
    ),
    MenuItem(
      id: 9,
      restaurantId: 2,
      name: 'Caesar Salad',
      category: 'Salad',
      description: 'A fresh drink',
      price: 1.99,
    ),
    MenuItem(
      id: 10,
      restaurantId: 3,
      name: 'CheeseBurger',
      category: 'Burger',
      description: 'A burger with Cheese',
      price: 9.99,
    ),
    MenuItem(
      id: 11,
      restaurantId: 4,
      name: 'Chocolate Cake',
      category: 'Desser',
      description: 'A cake with chocolate',
      price: 9.99,
    )
  ];
}
