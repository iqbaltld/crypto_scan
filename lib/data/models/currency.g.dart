// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      symbol: json['symbol'] as String?,
      pair: json['pair'] as String?,
      baseAsset: json['baseAsset'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'pair': instance.pair,
      'baseAsset': instance.baseAsset,
    };
