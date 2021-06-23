import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/models.dart';
import 'package:flutter_food_delivery_app/models/price_model.dart';

class FilterScreen extends StatelessWidget {
  static const String routeName = '/filters';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => FilterScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
            CustomPriceFilter(prices: Price.prices),
            Text(
              'Category',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
            CustomCategoryFilter(categories: Category.categories),
          ],
        ),
      ),
    );
  }
}

class CustomCategoryFilter extends StatelessWidget {
  final List<Category> categories;

  const CustomCategoryFilter({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categories[index].name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 25,
                  child: Checkbox(
                    value: false,
                    onChanged: (bool? newValue) {},
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CustomPriceFilter extends StatelessWidget {
  final List<Price> prices;
  const CustomPriceFilter({
    Key? key,
    required this.prices,
  }) : super(key: key);

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
                  price.price,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
