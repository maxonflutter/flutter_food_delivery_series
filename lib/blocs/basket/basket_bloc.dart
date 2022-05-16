import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../voucher/voucher_bloc.dart';
import '../../models/models.dart';

import '../../models/product_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;

  BasketBloc({required VoucherBloc voucherBloc})
      : _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<RemoveAllProduct>(_onRemoveAllProduct);
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

  void _onAddProduct(
    AddProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveAllProduct(
    RemoveAllProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;

    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)
                ..removeWhere((product) => product == event.product),
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
