// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCreateParam _$AccountCreateParamFromJson(Map<String, dynamic> json) =>
    AccountCreateParam(
      accountTypeUniqueNo: json['accountTypeUniqueNo'] as String,
    );

Map<String, dynamic> _$AccountCreateParamToJson(AccountCreateParam instance) =>
    <String, dynamic>{
      'accountTypeUniqueNo': instance.accountTypeUniqueNo,
    };

AccountTransactionHistoryParam _$AccountTransactionHistoryParamFromJson(
        Map<String, dynamic> json) =>
    AccountTransactionHistoryParam(
      accountNo: json['accountNo'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      transactionType: json['transactionType'] as String? ?? 'A',
      orderByType: json['orderByType'] as String,
    );

Map<String, dynamic> _$AccountTransactionHistoryParamToJson(
        AccountTransactionHistoryParam instance) =>
    <String, dynamic>{
      'accountNo': instance.accountNo,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'transactionType': instance.transactionType,
      'orderByType': instance.orderByType,
    };

AccountTransferParam _$AccountTransferParamFromJson(
        Map<String, dynamic> json) =>
    AccountTransferParam(
      depositAccountNo: json['depositAccountNo'] as String,
      transactionBalance: (json['transactionBalance'] as num).toInt(),
      withdrawalAccountNo: json['withdrawalAccountNo'] as String,
      depositTransferSummary: json['depositTransferSummary'] as String,
      withdrawalTransferSummary: json['withdrawalTransferSummary'] as String,
    );

Map<String, dynamic> _$AccountTransferParamToJson(
        AccountTransferParam instance) =>
    <String, dynamic>{
      'depositAccountNo': instance.depositAccountNo,
      'transactionBalance': instance.transactionBalance,
      'withdrawalAccountNo': instance.withdrawalAccountNo,
      'depositTransferSummary': instance.depositTransferSummary,
      'withdrawalTransferSummary': instance.withdrawalTransferSummary,
    };
