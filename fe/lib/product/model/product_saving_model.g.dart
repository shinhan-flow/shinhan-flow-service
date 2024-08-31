// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_saving_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSavingModel _$ProductSavingModelFromJson(Map<String, dynamic> json) =>
    ProductSavingModel(
      accountTypeUniqueNo: json['accountTypeUniqueNo'] as String,
      bankCode: json['bankCode'] as String,
      bankName: json['bankName'] as String,
      accountTypeCode: json['accountTypeCode'] as String,
      accountTypeName: json['accountTypeName'] as String,
      accountName: json['accountName'] as String,
      accountDescription: json['accountDescription'] as String,
      subscriptionPeriod: json['subscriptionPeriod'] as String,
      minSubscriptionBalance: json['minSubscriptionBalance'] as String,
      maxSubscriptionBalance: json['maxSubscriptionBalance'] as String,
      interestRate: (json['interestRate'] as num).toDouble(),
      rateDescription: json['rateDescription'] as String,
    );

Map<String, dynamic> _$ProductSavingModelToJson(ProductSavingModel instance) =>
    <String, dynamic>{
      'accountTypeUniqueNo': instance.accountTypeUniqueNo,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'accountTypeCode': instance.accountTypeCode,
      'accountTypeName': instance.accountTypeName,
      'accountName': instance.accountName,
      'accountDescription': instance.accountDescription,
      'subscriptionPeriod': instance.subscriptionPeriod,
      'minSubscriptionBalance': instance.minSubscriptionBalance,
      'maxSubscriptionBalance': instance.maxSubscriptionBalance,
      'interestRate': instance.interestRate,
      'rateDescription': instance.rateDescription,
    };
