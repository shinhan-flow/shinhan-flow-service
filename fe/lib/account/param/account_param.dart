import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/param/default_param.dart';

part 'account_param.g.dart';

@JsonSerializable()
class AccountCreateParam extends DefaultParam {
  final String accountTypeUniqueNo;

  AccountCreateParam({required this.accountTypeUniqueNo});

  @override
  List<Object?> get props => [
        accountTypeUniqueNo,
      ];

  Map<String, dynamic> toJson() => _$AccountCreateParamToJson(this);
}
