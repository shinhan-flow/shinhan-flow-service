import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/action/provider/widget/balance_notification_action_form_provider.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';
import '../model/enum/action_type.dart';

part 'action_balance_notification_param.g.dart';

@JsonSerializable()
class AcBalanceNotificationParam extends ActionBaseParam {
  final String account;

   AcBalanceNotificationParam({
    super.type = ActionType.BalanceNotificationAction,
    required this.account,
  });

  @override
  List<Object?> get props => [account, type];

  @override
  Map<String, dynamic> toJson() => _$AcBalanceNotificationParamToJson(this);

  factory AcBalanceNotificationParam.fromForm(
      {required AcBalanceNotificationFormModel form}) {
    return AcBalanceNotificationParam(
      account: form.account,
    );
  }


  factory AcBalanceNotificationParam.fromJson(Map<String, dynamic> json) =>
      _$AcBalanceNotificationParamFromJson(json);
}
