part of 'trends_bloc.dart';

@freezed
class TrendsState with _$TrendsState {
  const factory TrendsState.initial() = _Initial;
  const factory TrendsState.success(
      {required double realTimePrice,
      required List<double> historicalPrices,
      required List<DateTime> times}) = _Success;
  const factory TrendsState.error(String message) = _Error;
}
