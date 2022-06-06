import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';
import '/blocs/blocs.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketRepository _basketRepository;
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;

  BasketBloc({
    required BasketRepository basketRepository,
    required VoucherBloc voucherBloc,
  })  : _basketRepository = basketRepository,
        _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<RemoveAllProduct>(_onRemoveAllProduct);
    on<ToggleSwitch>(_onToggleSwitch);
    on<ApplyVoucher>(_onApplyVoucher);
    on<SelectDeliveryTime>(_onSelectDeliveryTime);

    _voucherSubscription = _voucherBloc.stream.listen((state) {
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
    Basket basket = await _basketRepository.getBasket();
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: basket));
    } catch (_) {}
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(
          products: List.from(state.basket.products)..add(event.product),
        );
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
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
        Basket basket = state.basket.copyWith(
          products: List.from(state.basket.products)..remove(event.product),
        );
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
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
        Basket basket = state.basket.copyWith(
          products: List.from(state.basket.products)
            ..removeWhere((product) => product == event.product),
        );
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (_) {}
    }
  }

  void _onToggleSwitch(
    ToggleSwitch event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      Basket basket = state.basket.copyWith(
        isCutlerySelected: !state.basket.isCutlerySelected,
      );
      _basketRepository.saveBasket(basket);
      emit(BasketLoaded(basket: basket));
    }
  }

  void _onApplyVoucher(
    ApplyVoucher event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(voucher: event.voucher);
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
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
        Basket basket = state.basket.copyWith(deliveryTime: event.deliveryTime);
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _voucherSubscription.cancel();
    return super.close();
  }
}
