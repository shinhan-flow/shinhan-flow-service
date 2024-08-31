// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_holder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountHolderModel _$AccountHolderModelFromJson(Map<String, dynamic> json) =>
    AccountHolderModel(
      bankCode: json['bankCode'] as String,
      bankName: json['bankName'] as String,
      userName: json['userName'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$AccountHolderModelToJson(AccountHolderModel instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'userName': instance.userName,
      'currency': instance.currency,
    };
