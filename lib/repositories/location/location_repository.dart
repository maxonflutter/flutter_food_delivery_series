import 'package:hive_flutter/hive_flutter.dart';

import '/datasources/datasources.dart';
import '/models/models.dart';
import 'base_location_repository.dart';

class LocationRepository extends BaseLocationRepository {
  final LocalDatasource localDatasource; // Hive local NoSQL storage.
  final PlacesAPI placesAPI;

  LocationRepository({
    required this.localDatasource,
    required this.placesAPI,
  });

  @override
  Future<List<Place>> getAutocomplete(String searchInput) async {
    return placesAPI.getAutocomplete(searchInput);
  }

  @override
  Future<Place?> getPlace([String? placeId]) async {
    if (placeId == null) {
      Box box = await localDatasource.openBox('user_location');
      Place? place = localDatasource.getPlace(box);
      return place;
    } else {
      final Place place = await placesAPI.getPlace(placeId);
      // Update the value in the local storage.
      Box box = await localDatasource.openBox('user_location');
      localDatasource.clearBox(box);
      localDatasource.addPlace(box, place);
      return place;
    }
  }
}
