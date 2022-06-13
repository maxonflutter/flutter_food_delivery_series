import '../../models/place_autocomplete_model.dart';
import '../../models/place_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}

  Future<Place?> getPlace(String placeId) async {}
}
