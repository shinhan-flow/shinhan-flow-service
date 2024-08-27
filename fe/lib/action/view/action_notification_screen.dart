import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/action/provider/widget/balance_notification_action_form_provider.dart';
import 'package:shinhan_flow/action/provider/widget/exchange_rate_notification_action_form_provider.dart';
import 'package:shinhan_flow/action/provider/widget/notifiacation_category_provider.dart';
import 'package:shinhan_flow/action/provider/widget/text_notification_action_form_provider.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/component/bottom_nav_button.dart';
import '../../common/component/default_text_button.dart';
import '../../common/component/drop_down_button.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../../flow/provider/widget/flow_form_provider.dart';
import '../../trigger/model/enum/foreign_currency_category.dart';
import '../model/enum/action_type.dart';
import '../param/action_param.dart';

class ActionNotificationScreen extends ConsumerWidget {
  static String get routeName => 'notification';

  const ActionNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(notificationCategoryProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavButton(child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final category = ref.watch(notificationCategoryProvider);
            bool valid = false;
            if (category == ActionType.balanceNotification) {
              valid = ref.watch(acBalanceNotificationFormProvider).valid;
            } else if (category == ActionType.exchangeRateNotification) {
              valid = ref.watch(acExchangeRateNotificationFormProvider).valid;
            } else if (category == ActionType.textNotification) {
              valid = ref.watch(acTextNotificationFormProvider).valid;
            }

            return DefaultTextButton(
              onPressed: valid
                  ? () {
                      selectNotification(category, ref, context);
                    }
                  : null,
              text: '완료',
              able: valid,
            );
          },
        )),
        body: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                const DefaultAppBar(
                  isSliver: true,
                  title: '알림 행동',
                )
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                SliverToBoxAdapter(
                  child: _NotificationTypeComponent(),
                ),
                if (category == ActionType.balanceNotification)
                  SliverToBoxAdapter(
                    child: _ActionBalanceForm(),
                  )
                else if (category == ActionType.exchangeRateNotification)
                  SliverToBoxAdapter(
                    child: _ActionExchangeRateForm(),
                  )
                else if (category == ActionType.textNotification)
                  SliverToBoxAdapter(
                    child: _ActionTextForm(),
                  )
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Text(
                        "원하시는 알림을 선택하여\nFlow를 더욱 활용해보세요!",
                        style: SHFlowTextStyle.subTitle,
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }

  void selectNotification(
      ActionType? category, WidgetRef ref, BuildContext context) {
    if (category == ActionType.balanceNotification) {
      final action = ref.read(acBalanceNotificationFormProvider);
      ref
          .read(flowFormProvider.notifier)
          .addAction(action: action.toParam() as ActionBaseParam);
    } else if (category == ActionType.exchangeRateNotification) {
      final action = ref.read(acExchangeRateNotificationFormProvider);
      ref
          .read(flowFormProvider.notifier)
          .addAction(action: action.toParam() as ActionBaseParam);
    } else if (category == ActionType.textNotification) {
      final action = ref.read(acTextNotificationFormProvider);
      ref
          .read(flowFormProvider.notifier)
          .addAction(action: action.toParam() as ActionBaseParam);
    }

    context.pop();
  }
}

class _NotificationTypeComponent extends ConsumerWidget {
  const _NotificationTypeComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(notificationCategoryProvider);
    final filters = ActionType.values
        .where((a) => a.isNotificationType())
        .map((a) => _NotificationFilter(
              isSelected: category == a,
              property: a,
              onTap: () {
                ref
                    .read(notificationCategoryProvider.notifier)
                    .update((n) => a);
              },
            ))
        .toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: filters,
    );
  }
}

class _NotificationFilter extends StatelessWidget {
  final ActionType property;
  final bool isSelected;
  final VoidCallback onTap;

  const _NotificationFilter({
    super.key,
    required this.isSelected,
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 85.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected ? const Color(0xFFA3C9FF) : const Color(0xFFE4ECF9),
        ),
        alignment: Alignment.center,
        child: Text(
          property.name,
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}

class _ActionTextForm extends ConsumerWidget {
  const _ActionTextForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: CustomTextFormField(
        hintText: '사용자 알림 내용을 입력해주세요.',
        onChanged: (v) {
          ref.read(acTextNotificationFormProvider.notifier).update(text: v);
        },
      ),
    );
  }
}

class _ActionBalanceForm extends ConsumerWidget {
  const _ActionBalanceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '알림에 필요한 계좌번호를 입력해주세요!',
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            hintText: '계좌번호를 입력해주세요',
            onChanged: (v) {
              ref
                  .read(acBalanceNotificationFormProvider.notifier)
                  .update(account: v);
            },
          ),
        ],
      ),
    );
  }
}

class _ActionExchangeRateForm extends ConsumerWidget {
  const _ActionExchangeRateForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '알림에 필요한 통화를 선택해주세요.',
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 12.h),
          CurrencyDropDownButton(),
        ],
      ),
    );
  }
}

class CurrencyDropDownButton extends ConsumerWidget {
  const CurrencyDropDownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(acExchangeRateNotificationFormProvider);

    return DropDownButton(
      value: form.currency.displayName,
      onChanged: (v) {
        if (v != null) {
          final currency = ForeignCurrencyCategory.stringToEnum(value: v);
          ref
              .read(acExchangeRateNotificationFormProvider.notifier)
              .update(currency: currency);
        }
      },
    );
  }
}
