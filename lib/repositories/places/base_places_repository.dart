import 'package:flutter_food_delivery_app/models/place_autocomplete_model.dart';
import 'package:flutter_food_delivery_app/models/place_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}

  Future<Place?> getPlace(String placeId) async {}
}
