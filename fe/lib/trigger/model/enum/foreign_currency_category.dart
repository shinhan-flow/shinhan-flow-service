import 'package:json_annotation/json_annotation.dart';

enum ForeignCurrencyCategory {
  @JsonValue("KRW")
  KRW('한국(원화)'),
  @JsonValue("USD")
  USD('미국(달러)'),
  @JsonValue("EUR")
  EUR('유럽연합(유로)'),
  @JsonValue("JPY")
  JPY('일본(엔화)'),
  @JsonValue("CNY")
  CNY('중국(위안화)'),
  @JsonValue("GBP")
  GBP('영국(파운드)'),
  @JsonValue("CHF")
  CHF('스위스(프랑)'),
  @JsonValue("CAD")
  CAD('캐나다(달러)');

  final String displayName;

  const ForeignCurrencyCategory(this.displayName);

  static ForeignCurrencyCategory stringToEnum({required String value}) {
    return ForeignCurrencyCategory.values
        .firstWhere((e) => e.displayName == value);
  }
}
