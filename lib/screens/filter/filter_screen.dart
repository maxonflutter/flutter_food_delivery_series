import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

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
      bottomNavigationBar: BottomAppBar(
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FilterLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(),
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text('Apply'),
                    onPressed: () {
                      print(state.filteredRestaurants);
                      Navigator.pushNamed(
                        context,
                        '/restaurant-listing',
                        arguments: state.filteredRestaurants,
                      );
                    },
                  );
                } else {
                  return Text('Something went wrong.');
                }
              },
            ),
          ],
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            CustomPriceFilter(),
            Text(
              'Category',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            CustomCategoryFilter(),
          ],
        ),
      ),
    );
  }
}
