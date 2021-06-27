import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/price_model.dart';

class CustomPriceFilter extends StatelessWidget {
  const CustomPriceFilter({
    Key? key,
    required this.prices,
  }) : super(key: key);

  final List<Price> prices;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: prices
          .map(
            (price) => InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${price.price}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
