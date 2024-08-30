import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shinhan_flow/account/view/account_transfer_screen.dart';
import 'package:shinhan_flow/action/view/action_exchange_screen.dart';
import 'package:shinhan_flow/common/component/default_flashbar.dart';

import '../../common/model/entity_enum.dart';
import '../../theme/text_theme.dart';
import '../../util/util.dart';
import '../model/account_model.dart';
import '../model/account_transaction_history_model.dart';

class AccountCard extends StatelessWidget {
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
  final VoidCallback? onTap;

  const AccountCard(
      {super.key,
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
      this.onTap});

  factory AccountCard.fromModel(
      {required AccountDetailModel model, VoidCallback? onTap}) {
    final accountBalance =
        FormatUtil.formatNumber(int.parse(model.accountBalance));

    return AccountCard(
      bankCode: model.bankCode,
      bankName: model.bankName,
      userName: model.userName,
      accountNo: model.accountNo,
      accountName: model.accountName,
      accountTypeCode: model.accountTypeCode,
      accountTypeName: model.accountTypeName,
      accountCreatedDate: model.accountCreatedDate,
      accountExpiryDate: model.accountExpiryDate,
      dailyTransferLimit: model.dailyTransferLimit,
      oneTimeTransferLimit: model.oneTimeTransferLimit,
      accountBalance: accountBalance,
      lastTransactionDate: model.lastTransactionDate,
      currency: model.currency,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final path = BankType.values.firstWhere((t) => t.bankName == bankName).img;

    return Container(
      height: 112.h,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: const Color(0xFF3F73FF)),
      child: Row(
        children: [
          Align(
            alignment: const Alignment(0, -0.6),
            child: Image.asset(
              AssetUtil.getAssetPath(
                name: path,
                extension: 'png',
              ),
              height: 27.5.r,
              width: 27.5.r,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      accountTypeName,
                      style: SHFlowTextStyle.body.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    //
                    // Text(
                    //   bankName,
                    //   style: SHFlowTextStyle.subTitle.copyWith(
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  child: Text(
                    accountNo,
                    style: SHFlowTextStyle.labelSmall.copyWith(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white),
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: accountNo));
                    FlashUtil.showFlash(context, '계좌번호가 복사되었습니다!',
                        textColor: const Color(0xFF49B7FF));
                  },
                ),
                const Spacer(),
                Text(
                  "$accountBalance 원",
                  style: SHFlowTextStyle.subTitle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8.r)),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Text(
                  "이체",
                  style:
                      SHFlowTextStyle.labelBold.copyWith(color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class TransactionHistoryCard extends StatelessWidget {
  final int transactionUniqueNo;
  final String transactionDate;
  final String transactionTime;
  final String transactionType;
  final String transactionTypeName;
  final String transactionAccountNo;
  final String transactionBalance;
  final String transactionAfterBalance;
  final String transactionSummary;
  final String transactionMemo;

  const TransactionHistoryCard(
      {super.key,
      required this.transactionUniqueNo,
      required this.transactionDate,
      required this.transactionTime,
      required this.transactionType,
      required this.transactionTypeName,
      required this.transactionAccountNo,
      required this.transactionBalance,
      required this.transactionAfterBalance,
      required this.transactionSummary,
      required this.transactionMemo});

  factory TransactionHistoryCard.fromModel(
      {required AccountTransactionHistoryModel model}) {
    final transactionBalance =
        FormatUtil.formatNumber(model.transactionBalance);
    final transactionAfterBalance =
        FormatUtil.formatNumber(model.transactionAfterBalance);
    final transactionDate = FormatUtil.formatDate(model.transactionDate);
    final transactionTime = FormatUtil.formatTime(model.transactionTime);

    return TransactionHistoryCard(
      transactionUniqueNo: model.transactionUniqueNo,
      transactionDate: transactionDate,
      transactionTime: transactionTime,
      transactionType: model.transactionType,
      transactionTypeName: model.transactionTypeName,
      transactionAccountNo: model.transactionAccountNo,
      transactionBalance: transactionBalance,
      transactionAfterBalance: transactionAfterBalance,
      transactionSummary: model.transactionSummary,
      transactionMemo: model.transactionMemo,
    );
  }

  String addCommas(String number) {
    // 숫자만 포함된 정규식
    final regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return number.replaceAllMapped(regExp, (Match match) => ',');
  }

  @override
  Widget build(BuildContext context) {
    final textColor = transactionType == '1'
        ? const Color(0xFFE21A1A)
        : const Color(0xFF0057FF);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFAAAAAA)),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  transactionTime,
                ),
                SizedBox(height: 30.h),
                Text(transactionDate)
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transactionTypeName,
                  style: SHFlowTextStyle.label.copyWith(
                    color: textColor,
                  ),
                ),
                Text(
                  '$transactionBalance 원',
                  style: SHFlowTextStyle.labelBold.copyWith(
                    color: textColor,
                  ),
                ),
                Text('잔액 $transactionAfterBalance 원'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
