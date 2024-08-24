import 'package:json_annotation/json_annotation.dart';

import '../../common/param/default_param.dart';

part 'notification_param.g.dart';
@JsonSerializable()
class NotificationParam extends DefaultParam {
  @JsonKey(name: 'fcm_token')
  final String fcmToken;

  NotificationParam({
    required this.fcmToken,
  });

  @override
  List<Object?> get props => [fcmToken];

  Map<String, dynamic> toJson() => _$NotificationParamToJson(this);
}
