part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Place place;
  final GoogleMapController? controller;
  final List<Restaurant>? restaurants;

  LocationLoaded({
    required this.place,
    this.controller,
    this.restaurants,
  });

  @override
  List<Object?> get props => [controller, place, restaurants];
}
