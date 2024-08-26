import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/flow/provider/widget/account_trigger_form_provider.dart';

import '../../../model/enum/widget/trigger_enum.dart';

part 'trigger_transfer_account_param.g.dart';

@JsonSerializable()
class TgAccountTransferParam extends TriggerBaseParam {
  final String fromAccount;
  final String toAccount;
  final int amount;

  TgAccountTransferParam({
    required this.fromAccount,
    required this.amount,
    required super.type,
    required this.toAccount,
  });

  @override
  List<Object?> get props => [
        type,
        fromAccount,
        amount,
        toAccount,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgAccountTransferParamToJson(this);

  factory TgAccountTransferParam.fromForm({required TgAccountFormModel form}) {
    return TgAccountTransferParam(
      fromAccount: form.fromAccount!,
      amount: form.amount!,
      type: form.type!,
      toAccount: form.toAccount!,
    );
  }
}
