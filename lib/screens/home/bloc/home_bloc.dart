import 'package:crypto_scan/data/models/currency.dart';
import 'package:crypto_scan/data/repositories/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<_Started>(_onStarted);
    on<_TabChanged>(_onTabChanged);
    on<_SearchChanged>(_onSearchChanged);
    on<_ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onStarted(_Started event, Emitter<HomeState> emit) async {
    var apiRepo = CryptoRepository();
    try {
      emit(const HomeState.loading());
      var currencies = await apiRepo.getExchangeInfo();
      emit(HomeState.success(
        currencies: currencies,
        filteredCurrencies: currencies,
        favoriteCurrencies: [],
      ));
    } on Exception catch (e) {
      emit(HomeState.error(error: e.toString()));
    }
  }

  void _onTabChanged(_TabChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }

  void _onSearchChanged(_SearchChanged event, Emitter<HomeState> emit) {
    emit(state.maybeMap(
      success: (_state) {
        final filtered = _state.currencies
            .where((currency) => currency.baseAsset!
                .toLowerCase()
                .contains(event.searchText.toLowerCase()))
            .toList();
        return _state.copyWith(filteredCurrencies: filtered);
      },
      orElse: () => state,
    ));
  }

  void _onToggleFavorite(_ToggleFavorite event, Emitter<HomeState> emit) {
    emit(state.maybeMap(
      success: (_state) {
        final newFavorite =
            _state.currencies.firstWhere((item) => item.symbol == event.symbol);
        List<Currency> updatedFavorites = List.from(_state.favoriteCurrencies);
        if (updatedFavorites.contains(newFavorite)) {
          updatedFavorites.remove(newFavorite);
        } else {
          updatedFavorites.add(newFavorite);
        }
        return _state.copyWith(favoriteCurrencies: updatedFavorites);
      },
      orElse: () => state,
    ));
  }
}
