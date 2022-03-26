part of 'restaurants_bloc.dart';

abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends RestaurantsEvent {
  final List<Restaurant> restaurants;

  LoadRestaurants(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}
