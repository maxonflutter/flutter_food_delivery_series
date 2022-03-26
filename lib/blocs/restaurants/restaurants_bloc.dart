import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantsSubscription;

  RestaurantsBloc({required RestaurantRepository restaurantRepository})
      : _restaurantRepository = restaurantRepository,
        super(RestaurantsLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);

    _restaurantsSubscription = _restaurantRepository
        .getRestaurants()
        .listen((restaurants) => add(LoadRestaurants(restaurants)));
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
    super.close();
  }
}
