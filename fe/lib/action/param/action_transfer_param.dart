import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/action/model/enum/action_type.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';
import '../provider/widget/transfer_action_form_provider.dart';

part 'action_transfer_param.g.dart';

@JsonSerializable()
class AcTransferParam extends ActionBaseParam {
  final int amount;
  final String fromAccount;
  final String toAccount;
  @JsonKey(includeToJson: false)
  final String holder;

  AcTransferParam({
    required this.toAccount,
    required this.amount,
    required this.fromAccount,
    super.type = ActionType.TransferAction,
    required this.holder,
  });

  @override
  List<Object?> get props => [
        type,
        toAccount,
        fromAccount,
        amount,
        // holder,
      ];

  @override
  Map<String, dynamic> toJson() => _$AcTransferParamToJson(this);

  factory AcTransferParam.fromForm({required AcTransferFormModel form}) {
    return AcTransferParam(
      toAccount: form.toAccount,
      amount: form.amount,
      fromAccount: form.fromAccount,
      holder: form.holder,
    );
  }
}
