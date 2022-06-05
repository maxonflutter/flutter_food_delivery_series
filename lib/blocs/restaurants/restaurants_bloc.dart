import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/blocs/location/location_bloc.dart';
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
          _restaurantsSubscription =
              _restaurantRepository.getNearbyRestaurants(state.place).listen(
            (restaurants) {
              add(
                LoadRestaurants(restaurants),
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

  @override
  Future<void> close() async {
    _restaurantsSubscription?.cancel();
    _locationSubscription?.cancel();
    super.close();
  }
}
