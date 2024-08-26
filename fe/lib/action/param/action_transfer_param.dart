import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/action/model/enum/action_type.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';

part 'action_transfer_param.g.dart';

@JsonSerializable()
class AcTransferParam extends ActionBaseParam {
  final String amount;

  // @JsonKey(name: 'from_account')
  final int fromAccount;

  // @JsonKey(name: 'to_account')
  final int toAccount;

   AcTransferParam({
    required this.toAccount,
    required this.amount,
    required this.fromAccount,
    super.type = ActionType.transfer,
  });

  @override
  List<Object?> get props => [
        type,
        toAccount,
        fromAccount,
        amount,
      ];

  @override
  Map<String, dynamic> toJson() => _$AcTransferParamToJson(this);

// factory AcTextNotificationParam.fromForm(
//     {required TgExchangeFormModel form}) {
//   return TgExchangeParam(
//     exRate: form.exRate,
//     currency: form.currency,
//   );
// }
}
