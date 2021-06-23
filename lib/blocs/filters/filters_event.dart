part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FilterLoad extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class CategoryFilterUpdated extends FiltersEvent {
  final CategoryFilter categoryFilter;

  CategoryFilterUpdated({
    required this.categoryFilter,
  });

  @override
  List<Object> get props => [categoryFilter];
}

class PriceFilterUpdated extends FiltersEvent {
  final PriceFilter priceFilter;

  PriceFilterUpdated({
    required this.priceFilter,
  });

  @override
  List<Object> get props => [priceFilter];
}
