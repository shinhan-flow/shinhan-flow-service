import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/common/component/bottom_nav_button.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/flow/model/enum/widget/trigger_enum.dart';
import 'package:shinhan_flow/flow/provider/widget/account_trigger_form_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/trigger_category_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/widget/account_property.dart';

import '../../common/component/default_appbar.dart';
import '../../util/text_form_formatter.dart';
import '../component/trigger_history_component.dart';

class AccountTriggerScreen extends StatelessWidget {
  static String get routeName => 'account';

  const AccountTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final valid =
                ref.watch(tgAccountFormProvider.select((form) => form.valid));
            return BottomNavButton(
              child: DefaultTextButton(
                onPressed: () {},
                text: '완료',
                able: valid,
              ),
            );
          },
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, __) {
              return [
                const DefaultAppBar(
                  title: '계좌 조건 설정',
                  isSliver: true,
                )
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(25.r),
                  sliver: const SliverToBoxAdapter(
                    child: _AccountFormComponent(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 8.h,
                    color: const Color(0xFFdae4ff),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TriggerHistoryComponent(),
                )
              ],
            )),
      ),
    );
  }
}

class _AccountFormComponent extends ConsumerWidget {
  const _AccountFormComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(tgAccountFormProvider);

    final filters = AccountProperty.values
        .map((a) => _AccountTriggerFilter(
              isSelected: form.property == a,
              property: a,
              onTap: () {
                ref.read(tgAccountFormProvider.notifier).update(property: a);
              },
            ))
        .toList();

    final thanChips = AccountThanType.values
        .map(
          (a) => _ThanChip(
            type: a,
            isSelected: form.thanType == a,
            onTap: () {
              ref.read(tgAccountFormProvider.notifier).update(thanType: a);
            },
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '계좌 조건',
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: filters,
        ),
        SizedBox(height: 24.h),
        Text('계좌 번호', style: SHFlowTextStyle.subTitle),
        SizedBox(height: 8.h),
        CustomTextFormField(
          hintText: '조건에 등록할 계좌번호를 입력해주세요.',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (v) {
            ref.read(tgAccountFormProvider.notifier).update(account: v);
          },
        ),
        SizedBox(height: 16.h),
        Text('계좌 금액', style: SHFlowTextStyle.subTitle),
        SizedBox(height: 8.h),
        CustomTextFormField(
          hintText: '조건에 등록할 금액을 입력해주세요.',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberFormatter(),
          ],
          onChanged: (v) {
            final price = int.parse(v.replaceAll(',', ''));
            ref.read(tgAccountFormProvider.notifier).update(price: price);
          },
        ),
        if (form.property == AccountProperty.balance) SizedBox(height: 24.h),
        Visibility(
          visible: form.property == AccountProperty.balance,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: thanChips,
          ),
        )
      ],
    );
  }
}

class _ThanChip extends StatelessWidget {
  final AccountThanType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThanChip(
      {super.key,
      required this.type,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            100.r,
          ),
          color: isSelected ? const Color(0xFFa3c9FF) : const Color(0xFFe4ecf9),
        ),
        child: Text(
          type.name,
          style: SHFlowTextStyle.labelBold,
        ),
      ),
    );
  }
}

class _AccountTriggerFilter extends StatelessWidget {
  final AccountProperty property;
  final bool isSelected;
  final VoidCallback onTap;

  const _AccountTriggerFilter({
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
          style: SHFlowTextStyle.subTitle,
        ),
      ),
    );
  }
}
