import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/blocs/location/location_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final RestaurantRepository _restaurantRepository;
  final LocationBloc _locationBloc;
  StreamSubscription? _restaurantsSubscription;
  StreamSubscription? _locationSubscription;

  RestaurantsBloc({
    required RestaurantRepository restaurantRepository,
    required LocationBloc locationBloc,
  })  : _restaurantRepository = restaurantRepository,
        _locationBloc = locationBloc,
        super(RestaurantsLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);

    _locationSubscription = _locationBloc.stream.listen(
      (state) {
        if (state is LocationLoaded) {
          final Place place = state.place;
          _restaurantsSubscription =
              _restaurantRepository.getRestaurants().listen(
            (restaurants) async {
              List<Restaurant> filteredRestaurants =
                  await _getNearbyRestaurants(restaurants, place);
              add(
                LoadRestaurants(filteredRestaurants),
              );
            },
          );
        }
      },
    );
  }

  void _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantsState> emit,
  ) {
    emit(RestaurantsLoaded(event.restaurants));
  }

  Future<List<Restaurant>> _getNearbyRestaurants(
    List<Restaurant> restaurants,
    Place place,
  ) async {
    return restaurants
        .where((restaurant) =>
            _getRestaurantDistance(restaurant.address, place) <= 10)
        .toList();
  }

  int _getRestaurantDistance(
    Place restaurantAddress,
    Place selectedAddress,
  ) {
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    var distanceInKm = geolocator.distanceBetween(
          restaurantAddress.lat.toDouble(),
          restaurantAddress.lon.toDouble(),
          selectedAddress.lat.toDouble(),
          selectedAddress.lon.toDouble(),
        ) ~/
        1000;
    return distanceInKm;
  }

  @override
  Future<void> close() async {
    _restaurantsSubscription?.cancel();
    _locationSubscription?.cancel();
    super.close();
  }
}
