import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/models.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where((restaurant) => restaurant.tags.contains(category.name))
        .toList();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant-listing',
            arguments: restaurants);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 7.5,
              child: category.image,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
