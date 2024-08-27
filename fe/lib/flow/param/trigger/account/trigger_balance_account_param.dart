import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/flow/provider/widget/account_trigger_form_provider.dart';

import '../../../model/enum/widget/trigger_enum.dart';

part 'trigger_balance_account_param.g.dart';

@JsonSerializable()
class TgAccountBalanceParam extends TriggerBaseParam {
  final String account;
  final int balance;
  final Condition condition;

  TgAccountBalanceParam({
    required this.account,
    required this.balance,
    required super.type,
    required this.condition,
  });

  @override
  List<Object?> get props => [
        type,
        account,
        balance,
        condition,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgAccountBalanceParamToJson(this);

  factory TgAccountBalanceParam.fromForm({required TgAccountFormModel form}) {
    return TgAccountBalanceParam(
      account: form.account!,
      balance: form.balance!,
      type: form.type!,
      condition: form.condition!,
    );
  }
}
