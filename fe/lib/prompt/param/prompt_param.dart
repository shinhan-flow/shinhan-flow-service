import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/param/default_param.dart';

part 'prompt_param.g.dart';

@JsonSerializable()
class PromptParam extends DefaultParam {
  final String input_string;

  PromptParam({required this.input_string});

  @override
  List<Object?> get props => [input_string];

  @override
  Map<String, dynamic> toJson() => _$PromptParamToJson(this);
}
