import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/enum/flow_type.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';

import '../../provider/widget/exchange_trigger_form_provider.dart';
import '../../provider/widget/product_trigger_form_provider.dart';

part 'trigger_exchange_param.g.dart';

@JsonSerializable()
class TgExchangeParam extends TriggerBaseParam {
  final CurrencyType? currency;
  final double? rate;

   TgExchangeParam({
    this.currency,
    this.rate,
    super.type = TriggerType.ExchangeRateTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        rate,
        currency,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgExchangeParamToJson(this);

  factory TgExchangeParam.fromForm({required TgExchangeFormModel form}) {
    return TgExchangeParam(
      rate: form.rate,
      currency: form.currency,
    );
  }


  factory TgExchangeParam.fromJson(Map<String, dynamic> json) =>
      _$TgExchangeParamFromJson(json);
}
