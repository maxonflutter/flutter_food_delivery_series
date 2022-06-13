import '/models/models.dart';

abstract class BaseRestaurantRepository {
  Stream<List<Restaurant>> getRestaurants();
  // Stream<Restaurant> getRestaurant();
}
