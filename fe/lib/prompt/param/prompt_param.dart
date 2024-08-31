import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/param/default_param.dart';

part 'prompt_param.g.dart';

@JsonSerializable()
class PromptParam extends DefaultParam {
  final String prompt;

  PromptParam({required this.prompt});

  @override
  List<Object?> get props => [prompt];

  @override
  Map<String, dynamic> toJson() => _$PromptParamToJson(this);
}
