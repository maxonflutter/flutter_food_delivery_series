import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/restaurants/restaurants_bloc.dart';

import '/models/models.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants = context.select((RestaurantsBloc bloc) {
      if (bloc.state is RestaurantsLoaded) {
        return (bloc.state as RestaurantsLoaded).restaurants;
      } else {
        return <Restaurant>[];
      }
    });

    final List<Restaurant> filteredRestaurants = restaurants
        .where((restaurant) => restaurant.categories.contains(category))
        .toList();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurant-listing',
          arguments: filteredRestaurants,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).colorScheme.secondary,
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
              child: Image.asset(category.imageUrl),
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
