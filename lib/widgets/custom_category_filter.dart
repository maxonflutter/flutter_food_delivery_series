import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/category_filter_model.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({
    Key? key,
    required this.categoryFilters,
  }) : super(key: key);

  final List<CategoryFilter> categoryFilters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CategoryFilter.filters.length,
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
                CategoryFilter.filters[index].category.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 25,
                child: Checkbox(
                  value: CategoryFilter.filters[index].value,
                  onChanged: (bool? newValue) {},
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
