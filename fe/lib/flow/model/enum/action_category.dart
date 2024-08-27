import 'package:json_annotation/json_annotation.dart';

enum ActionCategoryType {
  @JsonValue("NOTIFICATION")
  notification('알림'),
  @JsonValue("TRANSFER")
  transfer('송금'),
  @JsonValue("EXCHANGE")
  exchange('환율');

  final String name;

  const ActionCategoryType(this.name);
}

//NOTIFICATION, TRANSFER , EXCHANGE
