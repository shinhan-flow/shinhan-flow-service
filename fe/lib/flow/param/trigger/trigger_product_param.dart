import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';

import '../../provider/widget/product_trigger_form_provider.dart';
import '../enum/flow_type.dart';

part 'trigger_product_param.g.dart';

@JsonSerializable()
class TgProductParam extends TriggerBaseParam {
  final AccountProductType? accountProduct;
  final double? rate;

  TgProductParam({
    this.accountProduct,
    this.rate,
    super.type = TriggerType.InterestRateTrigger,
  });

  @override
  List<Object?> get props => [
        type,
        accountProduct,
        rate,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgProductParamToJson(this);

  factory TgProductParam.fromForm({required TgProductFormModel form}) {
    return TgProductFormModel(
      accountProduct: form.accountProduct,
      rate: form.rate,
    );
  }

  factory TgProductParam.fromJson(Map<String, dynamic> json) =>
      _$TgProductParamFromJson(json);
}
