import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/place_autocomplete_model.dart';
import '../../repositories/places/places_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
    on<ClearAutocomplete>(_onClearAutocomplete);
  }

  void _onLoadAutocomplete(
    LoadAutocomplete event,
    Emitter<AutocompleteState> emit,
  ) async {
    final List<PlaceAutocomplete> autocomplete =
        await _placesRepository.getAutocomplete(event.searchInput);

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
