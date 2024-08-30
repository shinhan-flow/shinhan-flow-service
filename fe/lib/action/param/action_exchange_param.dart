import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';
import '../model/enum/action_type.dart';
import '../provider/widget/exchange_action_form_provider.dart';

part 'action_exchange_param.g.dart';

@JsonSerializable()
class AcExchangeParam extends ActionBaseParam {
  final CurrencyType currency;
  final String fromAccount;
  final int amount;

  AcExchangeParam({
    required this.currency,
    required this.fromAccount,
    required this.amount,
    super.type = ActionType.ExchangeAction,
  });

  @override
  List<Object?> get props => [
        type,
        currency,
        amount,
        fromAccount,
      ];

  @override
  Map<String, dynamic> toJson() => _$AcExchangeParamToJson(this);

  factory AcExchangeParam.fromForm({required AcExchangeFormModel form}) {
    return AcExchangeParam(
      currency: form.currency,
      fromAccount: form.fromAccount,
      amount: form.amount,
    );
  }

  factory AcExchangeParam.fromJson(Map<String, dynamic> json) =>
      _$AcExchangeParamFromJson(json);
}
