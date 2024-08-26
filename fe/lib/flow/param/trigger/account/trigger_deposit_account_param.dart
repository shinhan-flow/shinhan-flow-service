import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/flow/provider/widget/account_trigger_form_provider.dart';

import '../../../model/enum/widget/trigger_enum.dart';

part 'trigger_deposit_account_param.g.dart';

@JsonSerializable()
class TgAccountDepositParam extends TriggerBaseParam {
  final String account;
  final int amount;

  TgAccountDepositParam({
    required this.account,
    required this.amount,
    required super.type,
  });

  @override
  List<Object?> get props => [
        type,
        account,
        amount,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgAccountDepositParamToJson(this);

  factory TgAccountDepositParam.fromForm({required TgAccountFormModel form}) {
    return TgAccountDepositParam(
      account: form.account!,
      amount: form.amount!,
      type: form.type!,
    );
  }
}
