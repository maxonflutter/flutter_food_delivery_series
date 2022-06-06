import 'package:hive_flutter/hive_flutter.dart';

import '/datasources/datasources.dart';
import '/models/models.dart';
import 'base_basket_repository.dart';

class BasketRepository extends BaseBasketRepository {
  final LocalDatasource localDatasource; // Hive local NoSQL storage.

  BasketRepository({required this.localDatasource});

  @override
  Future<Basket> getBasket() async {
    Box box = await localDatasource.openBox('user_basket');
    Basket? basket = localDatasource.getBasket(box);

    if (basket == null) {
      basket = Basket.empty;
    }
    return basket;
  }

  @override
  Future<void> saveBasket(Basket basket) async {
    Box box = await localDatasource.openBox('user_basket');
    localDatasource.clearBox(box);
    localDatasource.addBasket(box, basket);
  }

  // @override
  // Future<List<Place>> getAutocomplete(String searchInput) async {
  //   return placesAPI.getAutocomplete(searchInput);
  // }

  // @override
  // Future<Place?> getPlace([String? placeId]) async {
  //   if (placeId == null) {
  //     Box box = await localDatasource.openBox('user_Basket');
  //     Place? place = localDatasource.getPlace(box);
  //     return place;
  //   } else {
  //     final Place place = await placesAPI.getPlace(placeId);
  //     // Update the value in the local storage.
  //     Box box = await localDatasource.openBox('user_Basket');
  //     localDatasource.clearBox(box);
  //     localDatasource.addPlace(box, place);
  //     return place;
  //   }
  // }
}
