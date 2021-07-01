import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/models/menu_item_model.dart';
import 'package:flutter_food_delivery_app/models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading());

  @override
  Stream<BasketState> mapEventToState(
    BasketEvent event,
  ) async* {
    if (event is BasketStarted) {
      yield* _mapBasketStartedToState();
    } else if (event is BasketProductAdded) {
      yield* _mapBasketProductAddedToState(event, state);
    } else if (event is BasketProductRemoved) {
      yield* _mapBasketProductRemovedToState(event, state);
    }
  }

  Stream<BasketState> _mapBasketStartedToState() async* {
    yield BasketLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const BasketLoaded();
    } catch (_) {}
  }

  Stream<BasketState> _mapBasketProductAddedToState(
    BasketProductAdded event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: Basket(
            items: List.from(state.basket.items)..add(event.item),
          ),
        );
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapBasketProductRemovedToState(
    BasketProductRemoved event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: Basket(
            items: List.from(state.basket.items)..remove(event.item),
          ),
        );
      } catch (_) {}
    }
  }
}
