part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.tabChanged(int tabIndex) = _TabChanged;
  const factory HomeEvent.searchChanged(String searchText) = _SearchChanged;
  const factory HomeEvent.toggleFavorite(String symbol) = _ToggleFavorite;
}
