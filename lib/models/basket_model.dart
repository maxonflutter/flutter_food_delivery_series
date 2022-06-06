import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'models.dart';

part 'basket_model.g.dart';

const int DELIVERY_FEE = 5;

@HiveType(typeId: 1)
class Basket extends Equatable {
  @HiveField(0)
  final List<Product> products;
  @HiveField(1)
  final bool isCutlerySelected;
  @HiveField(2)
  final Voucher? voucher;
  @HiveField(3)
  final DeliveryTime? deliveryTime;

  const Basket({
    this.products = const <Product>[],
    this.isCutlerySelected = false,
    this.voucher,
    this.deliveryTime,
  });

  static const empty = Basket();

  Basket copyWith({
    List<Product>? products,
    bool? isCutlerySelected,
    Voucher? voucher,
    DeliveryTime? deliveryTime,
  }) {
    return Basket(
      products: products ?? this.products,
      isCutlerySelected: isCutlerySelected ?? this.isCutlerySelected,
      voucher: voucher ?? this.voucher,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  Map itemQuantity(products) {
    var quantity = Map();

    products.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return (voucher == null)
        ? subtotal + DELIVERY_FEE
        : subtotal + DELIVERY_FEE - voucher!.value;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get totalString => total(subtotal).toStringAsFixed(2);

  @override
  List<Object?> get props =>
      [products, isCutlerySelected, voucher, deliveryTime];
}
