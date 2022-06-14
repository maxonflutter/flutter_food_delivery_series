import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _placesSubscription;
  StreamSubscription? _geolocationSubscription;

  LocationBloc({
    required PlacesRepository placesRepository,
    required GeolocationRepository geolocationRepository,
  })  : _placesRepository = placesRepository,
        _geolocationRepository = geolocationRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    final Position position = await _geolocationRepository.getCurrentLocation();

    emit(
      LocationLoaded(
        controller: event.controller,
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place place = await _placesRepository.getPlace(event.placeId);

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(place.lat, place.lon),
      ),
    );

    emit(
      LocationLoaded(
        controller: state.controller,
        lat: place.lat,
        lng: place.lon,
      ),
    );
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
