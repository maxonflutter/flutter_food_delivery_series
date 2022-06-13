part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();

  @override
  List<Object> get props => [];
}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final List<Restaurant> restaurants;

  RestaurantsLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}
