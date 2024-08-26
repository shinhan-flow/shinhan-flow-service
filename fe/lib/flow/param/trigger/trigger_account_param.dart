import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

part 'trigger_account_param.g.dart';

@JsonSerializable()
class TgAccountParam extends TriggerBaseParam {
  final String account;
  final int price;

   TgAccountParam({
    required this.account,
    required this.price,
    required super.type,
  });

  @override
  List<Object?> get props => [
        type,
        account,
        price,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgAccountParamToJson(this);
}
