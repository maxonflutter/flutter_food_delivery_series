import 'package:equatable/equatable.dart';

import 'models.dart';

class Basket extends Equatable {
  final List<MenuItem> items;
  final bool cutlery;
  final Voucher? voucher;

  Basket({
    this.items = const <MenuItem>[],
    this.cutlery = false,
    this.voucher,
  });

  Basket copyWith({
    List<MenuItem>? items,
    bool? cutlery,
    Voucher? voucher,
  }) {
    return Basket(
      items: items ?? this.items,
      cutlery: cutlery ?? this.cutlery,
      voucher: voucher ?? this.voucher,
    );
  }

  @override
  List<Object?> get props => [
        items,
        cutlery,
        voucher,
      ];

  Map itemQuantity(items) {
    var quantity = Map();

    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      items.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return (voucher == null) ? subtotal + 5 : subtotal + 5 - voucher!.value;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal).toStringAsFixed(2);
}
