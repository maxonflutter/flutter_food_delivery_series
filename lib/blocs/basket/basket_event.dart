part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
}

class StartBasket extends BasketEvent {
  @override
  List<Object> get props => [];
}

class AddProduct extends BasketEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends BasketEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveAllProduct extends BasketEvent {
  final Product product;

  const RemoveAllProduct(this.product);

  @override
  List<Object> get props => [product];
}

class ToggleSwitch extends BasketEvent {
  const ToggleSwitch();

  @override
  List<Object?> get props => [];
}

class ApplyVoucher extends BasketEvent {
  final Voucher voucher;
  const ApplyVoucher(this.voucher);

  @override
  List<Object?> get props => [voucher];
}

class SelectDeliveryDay extends BasketEvent {
  const SelectDeliveryDay();

  @override
  List<Object?> get props => [];
}

class SelectDeliveryTime extends BasketEvent {
  final DeliveryTime deliveryTime;
  const SelectDeliveryTime(this.deliveryTime);

  @override
  List<Object?> get props => [deliveryTime];
}
