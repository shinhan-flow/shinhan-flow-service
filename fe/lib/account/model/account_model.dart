import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/flow/model/enum/widget/trigger_enum.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

import '../../common/model/default_model.dart';

part 'account_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class AccountBaseModel<T> {
  @JsonKey(name: 'REC')
  final T rec;

  AccountBaseModel({
    required this.rec,
  });

  factory AccountBaseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$AccountBaseModelFromJson(json, fromJsonT);
  }
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class BankListBaseModel<T> {
  @JsonKey(name: 'REC')
  final List<T> rec;

  BankListBaseModel({
    required this.rec,
  });


  factory BankListBaseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return _$BankListBaseModelFromJson(json, fromJsonT);
  }
}

@JsonSerializable()
class AccountModel extends BaseModel {
  final String bankCode;
  final String accountNo;
  final CurrencyModel currency;

  AccountModel({
    required this.bankCode,
    required this.accountNo,
    required this.currency,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}

@JsonSerializable()
class CurrencyModel {
  final ForeignCurrencyCategory currency;
  final String currencyName;

  CurrencyModel({
    required this.currency,
    required this.currencyName,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}

@JsonSerializable()
class AccountDetailModel {
  final String bankCode;
  final String bankName;
  final String userName;
  final String accountNo;
  final String accountName;
  final String accountTypeCode;
  final String accountTypeName;
  final String accountCreatedDate;
  final String accountExpiryDate;
  final String dailyTransferLimit;
  final String oneTimeTransferLimit;
  final String accountBalance;
  final String lastTransactionDate;
  final String currency;

/*
   "bankCode": "001",
            "bankName": "한국은행",
            "userName": "ssafy14",
            "accountNo": "0013671770116187",
            "accountName": "0824 테스트 상품",
            "accountTypeCode": "1",
            "accountTypeName": "수시입출금",
            "accountCreatedDate": "20240826",
            "accountExpiryDate": "20290826",
            "dailyTransferLimit": "500000000",
            "oneTimeTransferLimit": "100000000",
            "accountBalance": "0",
            "lastTransactionDate": "",
            "currency": "KRW"
 */
  AccountDetailModel({
    required this.bankCode,
    required this.bankName,
    required this.userName,
    required this.accountNo,
    required this.accountName,
    required this.accountTypeCode,
    required this.accountTypeName,
    required this.accountCreatedDate,
    required this.accountExpiryDate,
    required this.dailyTransferLimit,
    required this.oneTimeTransferLimit,
    required this.accountBalance,
    required this.lastTransactionDate,
    required this.currency,
  });

  factory AccountDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailModelFromJson(json);
}

//
// "{\"dates\": [\"2024-08-27\"],\"triggered\":true}"
// {"account": "3412312","balance": 412344,"condition": "LT"}
@JsonSerializable()
class TrashModel {
  // final String account;
  // final int balance;
  // final Condition condition;

  final List<String> dates;
  final bool triggered;

  TrashModel({
    required this.dates,
    required this.triggered,
    // required this.account,
    // required this.balance,
    // required this.condition,
  });

  factory TrashModel.fromJson(Map<String, dynamic> json) =>
      _$TrashModelFromJson(json);
}
