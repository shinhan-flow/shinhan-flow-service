import 'package:json_annotation/json_annotation.dart';

part 'account_holder_model.g.dart';

@JsonSerializable()
class AccountHolderModel {
  final String bankCode;
  final String bankName;
  final String userName;
  final String currency;

  AccountHolderModel({
    required this.bankCode,
    required this.bankName,
    required this.userName,
    required this.currency,
  });

  factory AccountHolderModel.fromJson(Map<String, dynamic> json) =>
      _$AccountHolderModelFromJson(json);
}
/*
            "bankCode": "001",
            "bankName": "한국은행",
            "userName": "ansdlsrb",
            "currency": "KRW"
 */
