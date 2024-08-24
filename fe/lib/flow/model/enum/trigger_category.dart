

import 'package:json_annotation/json_annotation.dart';

enum TriggerCategoryType {
  @JsonValue("TIME")
  time('시간'),
  @JsonValue("TRANSFER")
  transfer('금액'),
  @JsonValue("EXCHANGE")
  exchange('환율'),
  @JsonValue("PRODUCT")
  product('상품');
  final String name;
  const TriggerCategoryType(this.name);
}
//TIME, PRODUCT, TRANSFER, EXCHANGE

