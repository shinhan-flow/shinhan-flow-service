// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBalanceModel _$AccountBalanceModelFromJson(Map<String, dynamic> json) =>
    AccountBalanceModel(
      bankCode: json['bankCode'] as String,
      accountNo: json['accountNo'] as String,
      accountBalance: json['accountBalance'] as String,
      accountCreatedDate: json['accountCreatedDate'] as String,
      accountExpiryDate: json['accountExpiryDate'] as String,
      lastTransactionDate: json['lastTransactionDate'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountBalanceModelToJson(
        AccountBalanceModel instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'accountNo': instance.accountNo,
      'accountBalance': instance.accountBalance,
      'accountCreatedDate': instance.accountCreatedDate,
      'accountExpiryDate': instance.accountExpiryDate,
      'lastTransactionDate': instance.lastTransactionDate,
      'currency': instance.currency,
    };
