import 'package:json_annotation/json_annotation.dart';
import 'package:shinhan_flow/common/param/default_param.dart';

part 'account_param.g.dart';

@JsonSerializable()
class AccountCreateParam extends DefaultParam {
  final String accountTypeUniqueNo;

  AccountCreateParam({required this.accountTypeUniqueNo});

  @override
  List<Object?> get props => [
        accountTypeUniqueNo,
      ];

  Map<String, dynamic> toJson() => _$AccountCreateParamToJson(this);
}

@JsonSerializable()
class AccountTransactionHistoryParam extends DefaultParam {
  final String accountNo;
  final String startDate;
  final String endDate;
  final String transactionType;
  final String orderByType;

  //
  // "accountNo": "0010337226851755",
  // "startDate": "20240801",
  // "endDate": "20240930",
  // "transactionType": "A",
  // "orderByType": "DESC"

  AccountTransactionHistoryParam({
    required this.accountNo,
    required this.startDate,
    required this.endDate,
    this.transactionType = 'A',
    required this.orderByType,
  });

  @override
  List<Object?> get props => [
        accountNo,
        startDate,
        endDate,
        transactionType,
        orderByType,
      ];

  AccountTransactionHistoryParam copyWith({
    String? accountNo,
    String? startDate,
    String? endDate,
    String? transactionType,
    String? orderByType,
  }) {
    return AccountTransactionHistoryParam(
      accountNo: accountNo ?? this.accountNo,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      orderByType: orderByType ?? this.orderByType,
    );
  }

  Map<String, dynamic> toJson() => _$AccountTransactionHistoryParamToJson(this);
}
