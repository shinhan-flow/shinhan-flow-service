/*
         "bankCode": "001",
            "accountNo": "0015814197206855",
            "accountBalance": "0",
            "accountCreatedDate": "20240824",
            "accountExpiryDate": "20290824",
            "lastTransactionDate": "",
            "currency": "KRW"
 */

import 'package:json_annotation/json_annotation.dart';

part 'account_balance_model.g.dart';

@JsonSerializable()
class AccountBalanceModel {
  final String bankCode;
  final String accountNo;
  final String accountBalance;
  final String accountCreatedDate;
  final String accountExpiryDate;
  final String lastTransactionDate;
  final String currency;

  AccountBalanceModel({
    required this.bankCode,
    required this.accountNo,
    required this.accountBalance,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
    required this.lastTransactionDate,
    required this.currency,
  });

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceModelFromJson(json);
}
