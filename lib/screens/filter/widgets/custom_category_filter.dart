import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/filter/filter_bloc.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FilterLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.filter.categoryFilters.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.filter.categoryFilters[index].category.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 25,
                      child: Checkbox(
                          value: state.filter.categoryFilters[index].value,
                          onChanged: (bool? newValue) {
                            context.read<FilterBloc>().add(
                                  CategoryFilterUpdated(
                                    categoryFilter: state
                                        .filter.categoryFilters[index]
                                        .copyWith(
                                            value: !state.filter
                                                .categoryFilters[index].value),
                                  ),
                                );
                          }),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}
