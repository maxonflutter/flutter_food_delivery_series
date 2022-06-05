import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '/models/models.dart';

abstract class PlacesAPI {
  Future<List<Place>> getAutocomplete(String searchInput);
  Future<Place> getPlace(String placeId);
}

class PlacesAPIImpl extends PlacesAPI {
  final String key = 'API_KEY';
  final String types = 'geocode';

  static const baseUrl = 'https://maps.googleapis.com/maps/api/place';

  @override
  Future<List<Place>> getAutocomplete(String searchInput) async {
    final String url =
        '$baseUrl/autocomplete/json?input=$searchInput&types=$types&key=$key';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var results = json['predictions'] as List;
      return results.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url = '$baseUrl/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var results = json['result'] as Map<String, dynamic>;
      return Place.fromJson(results);
    } else {
      throw Exception();
    }
  }
}
