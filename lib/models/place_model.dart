import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 0)
class Place extends Equatable {
  @HiveField(0)
  final String placeId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double lon;

  Place({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.lon,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    if (json.keys.contains('place_id')) {
      return Place(
        placeId: json['place_id'],
        name: json['name'],
        lat: json['geometry']['location']['lat'],
        lon: json['geometry']['location']['lng'],
      );
    } else {
      return Place(
        placeId: json['placeId'],
        name: json['name'],
        lat: json['lat'],
        lon: json['lon'],
      );
    }
  }

  @override
  List<Object?> get props => [placeId, name, lat, lon];
}
