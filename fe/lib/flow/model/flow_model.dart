import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/model/default_model.dart';

part 'flow_model.g.dart';

@JsonSerializable()
class FlowModel extends IModelWithId {
  final int memberId;
  final String title;
  final String description;
  final bool enable;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  FlowModel({
    required super.id,
    required this.memberId,
    required this.title,
    required this.description,
    required this.enable,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory FlowModel.fromJson(Map<String, dynamic> json) =>
      _$FlowModelFromJson(json);
}
