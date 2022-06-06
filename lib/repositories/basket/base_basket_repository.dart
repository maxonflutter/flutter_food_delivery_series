import '/models/models.dart';

abstract class BaseBasketRepository {
  Future<Basket> getBasket();
  Future<void> saveBasket(Basket basket);
}
