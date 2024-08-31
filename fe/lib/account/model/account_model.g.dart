// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      bankCode: json['bankCode'] as String,
      accountNo: json['accountNo'] as String,
      currency:
          CurrencyModel.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'accountNo': instance.accountNo,
      'currency': instance.currency,
    };

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      currency: $enumDecode(_$CurrencyTypeEnumMap, json['currency']),
      currencyName: json['currencyName'] as String,
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'currency': _$CurrencyTypeEnumMap[instance.currency]!,
      'currencyName': instance.currencyName,
    };

const _$CurrencyTypeEnumMap = {
  CurrencyType.KRW: 'KRW',
  CurrencyType.USD: 'USD',
  CurrencyType.EUR: 'EUR',
  CurrencyType.JPY: 'JPY',
  CurrencyType.CNY: 'CNY',
  CurrencyType.GBP: 'GBP',
  CurrencyType.CHF: 'CHF',
  CurrencyType.CAD: 'CAD',
};

AccountDetailModel _$AccountDetailModelFromJson(Map<String, dynamic> json) =>
    AccountDetailModel(
      bankCode: json['bankCode'] as String,
      bankName: json['bankName'] as String,
      userName: json['userName'] as String,
      accountNo: json['accountNo'] as String,
      accountName: json['accountName'] as String,
      accountTypeCode: json['accountTypeCode'] as String,
      accountTypeName: json['accountTypeName'] as String,
      accountCreatedDate: json['accountCreatedDate'] as String,
      accountExpiryDate: json['accountExpiryDate'] as String,
      dailyTransferLimit: json['dailyTransferLimit'] as String,
      oneTimeTransferLimit: json['oneTimeTransferLimit'] as String,
      accountBalance: json['accountBalance'] as String,
      lastTransactionDate: json['lastTransactionDate'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountDetailModelToJson(AccountDetailModel instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'userName': instance.userName,
      'accountNo': instance.accountNo,
      'accountName': instance.accountName,
      'accountTypeCode': instance.accountTypeCode,
      'accountTypeName': instance.accountTypeName,
      'accountCreatedDate': instance.accountCreatedDate,
      'accountExpiryDate': instance.accountExpiryDate,
      'dailyTransferLimit': instance.dailyTransferLimit,
      'oneTimeTransferLimit': instance.oneTimeTransferLimit,
      'accountBalance': instance.accountBalance,
      'lastTransactionDate': instance.lastTransactionDate,
      'currency': instance.currency,
    };

TrashModel _$TrashModelFromJson(Map<String, dynamic> json) => TrashModel(
      dates: (json['dates'] as List<dynamic>).map((e) => e as String).toList(),
      triggered: json['triggered'] as bool,
    );

Map<String, dynamic> _$TrashModelToJson(TrashModel instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'triggered': instance.triggered,
    };
