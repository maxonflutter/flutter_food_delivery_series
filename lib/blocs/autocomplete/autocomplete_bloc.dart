import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final LocationRepository _locationRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
    on<ClearAutocomplete>(_onClearAutocomplete);
  }

  void _onLoadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    final List<Place> autocomplete =
        await _locationRepository.getAutocomplete(event.searchInput);

    emit(AutocompleteLoaded(autocomplete: autocomplete));
  }

  void _onClearAutocomplete(
    ClearAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    emit(AutocompleteLoaded(autocomplete: List.empty()));
  }

  @override
  Future<void> close() async {
    _placesSubscription?.cancel();
    super.close();
  }
}
