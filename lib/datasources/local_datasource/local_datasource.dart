import 'package:hive/hive.dart';

import '/models/models.dart';

abstract class LocalDatasource {
  Future<Box> openBox(String boxName);
  Future<void> clearBox(Box box);

  // Methods to store the location of the current user.
  Place? getPlace(Box box);
  Future<void> addPlace(Box box, Place place);

  // Methods to store the basket details.
  // Basket? getBasket(Box box);
  // Future<void> addBasket(Box box, Basket basket);
}

class LocalDatasourceImpl extends LocalDatasource {
  String boxName = 'user_location';
  Type boxType = Place;

  @override
  Future<Box> openBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  @override
  Future<void> clearBox(Box box) async {
    await box.clear();
  }

  @override
  Place? getPlace(Box box) {
    if (box.values.length > 0) {
      return box.values.first as Place;
    } else
      return null;
  }

  @override
  Future<void> addPlace(Box box, Place place) async {
    await box.put(place.placeId, place);
  }

  // @override
  // Basket? getBasket(Box box) {
  //   if (box.values.length > 0) {
  //     return box.values.first as Basket;
  //   } else
  //     return null;
  // }

  // @override
  // Future<void> addBasket(Box box, Basket basket) async {
  //   await box.add(basket);
  // }
}
