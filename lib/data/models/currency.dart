import 'package:json_annotation/json_annotation.dart';
part 'currency.g.dart';

@JsonSerializable()
class Currency {
  @JsonKey(name: 'symbol')
  final String? symbol;
  @JsonKey(name: 'pair')
  final String? pair;
  @JsonKey(name: 'baseAsset')
  final String? baseAsset;

  Currency({
    this.symbol,
    this.pair,
    this.baseAsset,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
