import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/param/trigger/trigger_param.dart';
import 'package:shinhan_flow/trigger/model/enum/product_property.dart';

import '../../provider/widget/product_trigger_form_provider.dart';

part 'trigger_product_param.g.dart';

@JsonSerializable()
class TgProductParam extends TriggerBaseParam {
  final ProductProperty? product;
  @JsonKey(name: 'interest_rate')
  final double? interestRate;

  const TgProductParam({
    this.product,
    this.interestRate,
  });

  @override
  List<Object?> get props => [
        product,
        interestRate,
      ];

  @override
  Map<String, dynamic> toJson() => _$TgProductParamToJson(this);

  factory TgProductParam.fromForm({required TgProductFormModel form}) {
    return TgProductFormModel(
      product: form.product,
      interestRate: form.interestRate,
    );
  }
}
