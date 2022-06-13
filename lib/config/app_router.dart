import 'package:flutter/material.dart';
import '../screens/screens.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      case DeliveryTimeScreen.routeName:
        return DeliveryTimeScreen.route();
      case EditBasketScreen.routeName:
        return EditBasketScreen.route();
      case RestaurantDetailsScreen.routeName:
        return RestaurantDetailsScreen.route(
            restaurant: settings.arguments as Restaurant);
      case RestaurantListingScreen.routeName:
        return RestaurantListingScreen.route(
            restaurants: settings.arguments as List<Restaurant>);

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
