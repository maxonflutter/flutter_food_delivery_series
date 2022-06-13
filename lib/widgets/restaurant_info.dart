import 'package:flutter/material.dart';

import '../models/models.dart';
import 'restaurant_tags.dart';

class RestaurantInformation extends StatelessWidget {
  const RestaurantInformation({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          SizedBox(height: 10),
          RestaurantTags(restaurant: restaurant),
          SizedBox(height: 5),
          Text(
            '${restaurant.distance}km away - \$${restaurant.deliveryFee} delivery fee',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 10),
          Text(
            'Restaurant Information',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 5),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
