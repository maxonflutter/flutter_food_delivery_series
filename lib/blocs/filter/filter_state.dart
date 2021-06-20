part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final Filter filter;

  const FilterLoaded({
    this.filter = const Filter(),
  });

  @override
  List<Object> get props => [filter];
}
