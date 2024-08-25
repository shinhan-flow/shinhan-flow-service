import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';

part 'trigger_account_param.g.dart';

@JsonSerializable()
class TgAccountParam extends TriggerBaseParam {
  final String account;
  final int price;

  const TgAccountParam({
    required this.account,
    required this.price,
  });

  @override
  List<Object?> get props => [
        account,
        price,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgAccountParamToJson(this);
}
