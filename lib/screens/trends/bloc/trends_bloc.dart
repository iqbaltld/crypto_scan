import 'dart:convert';

import 'package:crypto_scan/data/repositories/crypto_repository.dart';
import 'package:crypto_scan/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'trends_event.dart';
part 'trends_state.dart';
part 'trends_bloc.freezed.dart';

class TrendsBloc extends Bloc<TrendsEvent, TrendsState> {
  final String symbol;
  TrendsBloc(this.symbol) : super(const TrendsState.initial()) {
    on<_Started>(_onStarted);
    on<_ReceivedSocketUpdate>(_onReceivedSocketUpdate);
  }

  WebSocketChannel? channel;

  Future<void> _onStarted(_Started event, Emitter<TrendsState> emit) async {
    // Connect to WebSocket
    channel = WebSocketChannel.connect(Uri.parse(
            '${AppConstants.webSocketUrl}/${symbol.toLowerCase()}@ticker'));
    channel!.stream.listen((data) {
      final parsed = jsonDecode(data);
      final price = double.parse(parsed['c']);
      add(_ReceivedSocketUpdate(price));
    });

    // Fetch historical data for past 24 hours
    var apiRepo = CryptoRepository();
    try {
      final now = DateTime.now();
      final startTime =
          now.subtract(const Duration(days: 1)).millisecondsSinceEpoch;
      final endTime = now.millisecondsSinceEpoch;
      var jsonData = await apiRepo.getHistoryData(symbol, startTime, endTime);
      List<double> historicalPrices =
          jsonData.map<double>((kline) => double.parse(kline[4])).toList();
      print(historicalPrices[0]);
      List<DateTime> times = jsonData
          .map<DateTime>(
              (kline) => DateTime.fromMillisecondsSinceEpoch(kline[0]))
          .toList();
      emit(TrendsState.success(
          realTimePrice: 0, historicalPrices: historicalPrices, times: times));
    } catch (e) {
      emit(TrendsState.error(e.toString()));
    }
  }

  void _onReceivedSocketUpdate(
      _ReceivedSocketUpdate event, Emitter<TrendsState> emit) {
    state.mapOrNull(
      success: (_state) {
        emit(_state.copyWith(realTimePrice: event.price));
      },
    );
  }

  @override
  Future<void> close() {
    channel?.sink.close();
    return super.close();
  }
}
