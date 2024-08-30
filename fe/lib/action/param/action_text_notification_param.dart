import 'package:json_annotation/json_annotation.dart';

import '../../flow/param/trigger/trigger_param.dart';
import '../model/enum/action_type.dart';
import '../provider/widget/text_notification_action_form_provider.dart';

part 'action_text_notification_param.g.dart';

@JsonSerializable()
class AcTextNotificationParam extends ActionBaseParam {
  final String text;

   AcTextNotificationParam({
    required this.text,
    super.type = ActionType.TextNotificationAction,
  });

  @override
  List<Object?> get props => [text, type];

  @override
  Map<String, dynamic> toJson() => _$AcTextNotificationParamToJson(this);

  factory AcTextNotificationParam.fromForm(
      {required AcTextNotificationFormModel form}) {
    return AcTextNotificationParam(
      text: form.text,
    );
  }

  factory AcTextNotificationParam.fromJson(Map<String, dynamic> json) =>
      _$AcTextNotificationParamFromJson(json);
}
