// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_transaction_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTransferModel _$AccountTransferModelFromJson(
        Map<String, dynamic> json) =>
    AccountTransferModel(
      transactionUniqueNo: (json['transactionUniqueNo'] as num?)?.toInt(),
      transactionAccountNO: json['transactionAccountNO'] as String?,
      transactionDate: json['transactionDate'] as String,
      transactionType: json['transactionType'] as String,
      transactionTypeName: json['transactionTypeName'] as String,
    );

Map<String, dynamic> _$AccountTransferModelToJson(
        AccountTransferModel instance) =>
    <String, dynamic>{
      'transactionUniqueNo': instance.transactionUniqueNo,
      'transactionAccountNO': instance.transactionAccountNO,
      'transactionDate': instance.transactionDate,
      'transactionType': instance.transactionType,
      'transactionTypeName': instance.transactionTypeName,
    };

AccountTransactionHistoryModel _$AccountTransactionHistoryModelFromJson(
        Map<String, dynamic> json) =>
    AccountTransactionHistoryModel(
      transactionUniqueNo: (json['transactionUniqueNo'] as num).toInt(),
      transactionDate: json['transactionDate'] as String,
      transactionTime: json['transactionTime'] as String,
      transactionType: json['transactionType'] as String,
      transactionTypeName: json['transactionTypeName'] as String,
      transactionAccountNo: json['transactionAccountNo'] as String,
      transactionBalance: (json['transactionBalance'] as num).toInt(),
      transactionAfterBalance: (json['transactionAfterBalance'] as num).toInt(),
      transactionSummary: json['transactionSummary'] as String,
      transactionMemo: json['transactionMemo'] as String,
    );

Map<String, dynamic> _$AccountTransactionHistoryModelToJson(
        AccountTransactionHistoryModel instance) =>
    <String, dynamic>{
      'transactionUniqueNo': instance.transactionUniqueNo,
      'transactionDate': instance.transactionDate,
      'transactionTime': instance.transactionTime,
      'transactionType': instance.transactionType,
      'transactionTypeName': instance.transactionTypeName,
      'transactionAccountNo': instance.transactionAccountNo,
      'transactionBalance': instance.transactionBalance,
      'transactionAfterBalance': instance.transactionAfterBalance,
      'transactionSummary': instance.transactionSummary,
      'transactionMemo': instance.transactionMemo,
    };
