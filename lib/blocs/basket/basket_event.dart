part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
}

class BasketStarted extends BasketEvent {
  @override
  List<Object> get props => [];
}

class BasketProductAdded extends BasketEvent {
  final MenuItem item;

  const BasketProductAdded(this.item);

  @override
  List<Object> get props => [item];
}

class BasketProductRemoved extends BasketEvent {
  final MenuItem item;

  const BasketProductRemoved(this.item);

  @override
  List<Object> get props => [item];
}
