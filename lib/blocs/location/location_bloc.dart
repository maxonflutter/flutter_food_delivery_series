import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  final GeolocationRepository _geolocationRepository;
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geolocationSubscription;
  StreamSubscription? _restaurantsSubscription;

  LocationBloc({
    required LocationRepository locationRepository,
    required GeolocationRepository geolocationRepository,
    required RestaurantRepository restaurantRepository,
  })  : _locationRepository = locationRepository,
        _geolocationRepository = geolocationRepository,
        _restaurantRepository = restaurantRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    Place? place = await _locationRepository.getPlace();

    if (place == null) {
      final Position position =
          await _geolocationRepository.getCurrentLocation();

      place = Place(
        lat: position.latitude,
        lon: position.longitude,
      );
    }

    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;

    emit(
      LocationLoaded(
        controller: event.controller,
        place: place,
        restaurants: restaurants,
      ),
    );
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place place =
        await _locationRepository.getPlace(event.placeId) ?? Place.empty;

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          place.lat,
          place.lon,
        ),
      ),
    );

    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;

    emit(
      LocationLoaded(
        controller: state.controller,
        place: place,
        restaurants: restaurants,
      ),
    );
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    _restaurantsSubscription?.cancel();
    return super.close();
  }
}
