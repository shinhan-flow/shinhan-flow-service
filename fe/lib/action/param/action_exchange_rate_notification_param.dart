import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/action/model/enum/action_type.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';

part 'action_exchange_rate_notification_param.g.dart';

@JsonSerializable()
class AcExchangeRateNotificationParam extends ActionBaseParam {
  final ForeignCurrencyCategory currency;

   AcExchangeRateNotificationParam({
    required this.currency,
    super.type = ActionType.ExchangeRateNotificationAction,
  });

  @override
  List<Object?> get props => [currency, type];

  @override
  Map<String, dynamic> toJson() =>
      _$AcExchangeRateNotificationParamToJson(this);

  factory AcExchangeRateNotificationParam.fromForm(
      {required AcExchangeRateNotificationParam form}) {
    return AcExchangeRateNotificationParam(
      currency: form.currency,
    );
  }
}
