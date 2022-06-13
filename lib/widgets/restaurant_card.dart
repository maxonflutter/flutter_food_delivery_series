import 'package:flutter/material.dart';
import '../models/models.dart';

import 'restaurant_tags.dart';

import 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurant-details',
          arguments: restaurant,
        );
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 60,
                  height: 30,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${restaurant.deliveryTime} min',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name,
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(height: 5),
                    RestaurantTags(restaurant: restaurant),
                    SizedBox(height: 5),
                    Text(
                      '${restaurant.distance}km away - \$${restaurant.deliveryFee} delivery fee',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
