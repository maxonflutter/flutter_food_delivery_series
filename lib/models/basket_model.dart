import 'package:equatable/equatable.dart';
import 'product_model.dart';

import 'models.dart';

const int DELIVERY_FEE = 5;

class Basket extends Equatable {
  final List<Product> products;
  final bool isCutlerySelected;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  Basket({
    this.products = const <Product>[],
    this.isCutlerySelected = false,
    this.voucher,
    this.deliveryTime,
  });

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
