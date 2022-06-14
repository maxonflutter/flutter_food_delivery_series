part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final GoogleMapController? controller;
  final Place place;
  // final double lat;
  // final double lng;

  LocationLoaded({
    this.controller,
    required this.place,
    // required this.lat,
    // required this.lng,
  });

  @override
  List<Object?> get props => [
        controller,
        place,
      ];
}
