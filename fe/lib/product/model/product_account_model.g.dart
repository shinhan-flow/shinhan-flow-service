// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAccountModel _$ProductAccountModelFromJson(Map<String, dynamic> json) =>
    ProductAccountModel(
      accountTypeUniqueNo: json['accountTypeUniqueNo'] as String,
      bankCode: json['bankCode'] as String,
      bankName: json['bankName'] as String,
      accountTypeCode: json['accountTypeCode'] as String,
      accountTypeName: json['accountTypeName'] as String,
      accountName: json['accountName'] as String,
      accountDescription: json['accountDescription'] as String,
      accountType: json['accountType'] as String,
    );

Map<String, dynamic> _$ProductAccountModelToJson(
        ProductAccountModel instance) =>
    <String, dynamic>{
      'accountTypeUniqueNo': instance.accountTypeUniqueNo,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'accountTypeCode': instance.accountTypeCode,
      'accountTypeName': instance.accountTypeName,
      'accountName': instance.accountName,
      'accountDescription': instance.accountDescription,
      'accountType': instance.accountType,
    };
