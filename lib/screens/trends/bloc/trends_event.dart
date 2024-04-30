part of 'trends_bloc.dart';

@freezed
class TrendsEvent with _$TrendsEvent {
  const factory TrendsEvent.started() = _Started;
  const factory TrendsEvent.receivedSocketUpdate(double price) = _ReceivedSocketUpdate;
}

