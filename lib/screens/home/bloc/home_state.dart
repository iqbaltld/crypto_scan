part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(0) int tabIndex,
  }) = _InitialState;
  const factory HomeState.loading({@Default(0) int tabIndex}) = _Loading;
  const factory HomeState.success({
    @Default(0) int tabIndex,
    required List<Currency> currencies,
    required List<Currency> filteredCurrencies,
    required List<Currency> favoriteCurrencies,
  }) = _Success;
  const factory HomeState.error({@Default(0) int tabIndex, String? error}) =
      _Error;
}
