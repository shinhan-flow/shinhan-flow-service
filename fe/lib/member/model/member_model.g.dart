// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt,
    };

MemberCreditScoreModel _$MemberCreditScoreModelFromJson(
        Map<String, dynamic> json) =>
    MemberCreditScoreModel(
      ratingName: json['ratingName'] as String,
      demandDepositAssetValue: (json['demandDepositAssetValue'] as num).toInt(),
      depositSavingsAssetValue:
          (json['depositSavingsAssetValue'] as num).toInt(),
      totalAssetValue: (json['totalAssetValue'] as num).toInt(),
    );

Map<String, dynamic> _$MemberCreditScoreModelToJson(
        MemberCreditScoreModel instance) =>
    <String, dynamic>{
      'ratingName': instance.ratingName,
      'demandDepositAssetValue': instance.demandDepositAssetValue,
      'depositSavingsAssetValue': instance.depositSavingsAssetValue,
      'totalAssetValue': instance.totalAssetValue,
    };
