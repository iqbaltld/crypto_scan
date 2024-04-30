import 'dart:async';
import 'dart:convert';
import 'package:crypto_scan/data/models/currency.dart';
import 'package:crypto_scan/utils/constants.dart';
import 'package:http/http.dart' as http;

class CryptoRepository {
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<List<Currency>> getExchangeInfo() async {
    try {
      var requestUrl =
          Uri.parse('${AppConstants.baseUrl}/fapi/v1/exchangeInfo');
      var response = await http.get(requestUrl, headers: headers);
      switch (response.statusCode) {
        case 200:
          var json = await jsonDecode(response.body);
          List<Currency> data = (json['symbols'] as List)
              .map((item) => Currency.fromJson(item))
              .toList();
          return data;
        case 401:
          throw Exception('Un authorized');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception('Error while fetching data');
      }
    } catch (e) {
      print('$runtimeType Error while fetching data');
      rethrow;
    }
  }

  Future<List<dynamic>> getHistoryData(
      String symbol, int startTime, int endTime) async {
    try {
      var requestUrl = Uri.parse(
          '${AppConstants.baseUrl}/api/v3/klines?symbol=$symbol&interval=1h&startTime=$startTime&endTime=$endTime&limit=24');
      print(requestUrl);
      var response = await http.get(requestUrl, headers: headers);
      switch (response.statusCode) {
        case 200:
          List<dynamic> jsonData = jsonDecode(response.body);
          return jsonData;
        case 401:
          throw Exception('Un authorized');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception('Error while fetching data');
      }
    } catch (e) {
      print('$runtimeType Error while fetching data');
      rethrow;
    }
  }
}
