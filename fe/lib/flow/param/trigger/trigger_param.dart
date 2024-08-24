/*
1. 주기생성
    1. 일반(0)
        날짜를 단 하루 지정합니다.
    2. 기간(1)
        연속된 날짜를 지정합니다.
    3. 반복(2)
        1. 매주
            매주 반복되는 요일을 설정합니다.
            시작 날짜필수 종료날짜 미선택시 무한반복
        2. 매월
            매달 특정일을 지정해서 반복합니다.
            1일, 12일, 29일 등등
    4. 다중(3)
        마구잡이로 여러 날짜를 선택합니다.
 */
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/param/default_param.dart';
import '../enum/flow_type.dart';

part 'trigger_param.g.dart';

@JsonSerializable()
class TriggerParam extends DefaultParam{
  final FlowType code;
  final TriggerBaseParam data;

  TriggerParam({
    required this.code,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$TriggerParamToJson(this);

  factory TriggerParam.fromJson(Map<String, dynamic> json) =>
      _$TriggerParamFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [code, data];


}

@JsonSerializable()
class TriggerBaseParam extends Equatable {
  const TriggerBaseParam();

  Map<String, dynamic> toJson() {
    return {};
  }

  factory TriggerBaseParam.fromJson(Map<String, dynamic> json) =>
      _$TriggerBaseParamFromJson(json);

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
