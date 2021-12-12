import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/blocs/voucher/voucher_bloc.dart';
import 'package:flutter_food_delivery_app/models/menu_item_model.dart';
import 'package:flutter_food_delivery_app/models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;

  BasketBloc({required VoucherBloc voucherBloc})
      : _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<RemoveAllItem>(_onRemoveAllItem);
    on<ToggleSwitch>(_onToggleSwitch);
    on<ApplyVoucher>(_onApplyVoucher);
    on<SelectDeliveryTime>(_onSelectDeliveryTime);

    _voucherSubscription = voucherBloc.stream.listen((state) {
      if (state is VoucherSelected)
        add(
          ApplyVoucher(state.voucher),
        );
    });
  }

  void _onStartBasket(
    StartBasket event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: Basket()));
    } catch (_) {}
  }

  void _onAddItem(
    AddItem event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)..add(event.item),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveItem(
    RemoveItem event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)..remove(event.item),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveAllItem(
    RemoveAllItem event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;

    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              items: List.from(state.basket.items)
                ..removeWhere((item) => item == event.item),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onToggleSwitch(
    ToggleSwitch event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      emit(
        BasketLoaded(
          basket: state.basket.copyWith(cutlery: !state.basket.cutlery),
        ),
      );
    }
  }

  void _onApplyVoucher(
    ApplyVoucher event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(voucher: event.voucher),
          ),
        );
      } catch (_) {}
    }
  }

  void _onSelectDeliveryTime(
    SelectDeliveryTime event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(deliveryTime: event.deliveryTime),
          ),
        );
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _voucherSubscription.cancel();
    return super.close();
  }
}
