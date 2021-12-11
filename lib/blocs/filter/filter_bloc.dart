import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_delivery_app/models/category_filter_model.dart';
import 'package:flutter_food_delivery_app/models/filter_model.dart';
import 'package:flutter_food_delivery_app/models/price_filter_model.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
    on<UpdatePriceFilter>(_onUpdatePriceFilter);
  }

  void _onLoadFilter(
    LoadFilter event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      FilterLoaded(
        filter: Filter(
          categoryFilters: CategoryFilter.filters,
          priceFilters: PriceFilter.filters,
        ),
      ),
    );
  }

  void _onUpdateCategoryFilter(
    UpdateCategoryFilter event,
    Emitter<FilterState> emit,
  ) async {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();
      emit(
        FilterLoaded(
          filter: Filter(
            categoryFilters: updatedCategoryFilters,
            priceFilters: state.filter.priceFilters,
          ),
        ),
      );
    }
  }

  void _onUpdatePriceFilter(
    UpdatePriceFilter event,
    Emitter<FilterState> emit,
  ) async {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();
      emit(
        FilterLoaded(
          filter: Filter(
            categoryFilters: state.filter.categoryFilters,
            priceFilters: updatedPriceFilters,
          ),
        ),
      );
    }
  }
}
