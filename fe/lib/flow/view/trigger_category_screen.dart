import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/auth/view/login_screen.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/common/component/text_input_form.dart';
import 'package:shinhan_flow/flow/provider/widget/trigger_category_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/view/flow_init_screen.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../../common/component/bottom_nav_button.dart';
import '../model/enum/trigger_category.dart';

class TriggerCategoryScreen extends ConsumerWidget {
  static String get routeName => 'triggerCategory';

  const TriggerCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategories = ref.watch(triggerCategoryProvider);

    List<_CategoryCard> cards = _toTriggerCards(selectedCategories, ref);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: BottomNavButton(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final form = ref.watch(flowFormProvider);

              final valid = selectedCategories.isNotEmpty &&
                  form.title.isNotEmpty &&
                  form.description.isNotEmpty;
              return DefaultTextButton(
                onPressed: () => context.pushNamed(FlowInitScreen.routeName),
                text: '다음',
                able: true,
              );
            },
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const DefaultAppBar(
                  isSliver: true,
                  title: 'Flow 생성',
                )
              ];
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: _FlowFormComponent(),
                  ),
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(bottom: 24.h, top: 30.h),
                  //     child: Text(
                  //       '조건 카테고리를 선택해주세요!',
                  //       style: SHFlowTextStyle.subTitle,
                  //     ),
                  //   ),
                  // ),
                  // SliverList.separated(
                  //   itemBuilder: (_, idx) {
                  //     return cards[idx];
                  //   },
                  //   separatorBuilder: (_, idx) => SizedBox(height: 21.h),
                  //   itemCount: cards.length,
                  // ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 30.h),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  List<_CategoryCard> _toTriggerCards(
      Set<TriggerCategoryType> selectedCategories, WidgetRef ref) {
    final cards = TriggerCategoryType.values
        .map((v) => _CategoryCard(
              onTap: () {
                if (selectedCategories.add(v)) {
                  ref
                      .read(triggerCategoryProvider.notifier)
                      .update((v) => selectedCategories.toSet());
                } else {
                  selectedCategories.remove(v);
                }
                ref
                    .read(triggerCategoryProvider.notifier)
                    .update((v) => selectedCategories.toSet());
              },
              name: v.name,
              isSelected: selectedCategories.contains(v),
            ))
        .toList();
    return cards;
  }
}

class _FlowFormComponent extends ConsumerWidget {
  const _FlowFormComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30.h),
        Text(
          "Flow를 생성하여\n손 쉽게 업무를 진행해보세요!",
          style: SHFlowTextStyle.subTitle,
        ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          hintText: '플로우명을 입력해주세요.',
          label: '플로우명',
          onChanged: (v) {
            ref.read(flowFormProvider.notifier).update(title: v);
          },
        ),
        SizedBox(height: 12.h),
        CustomTextFormField(
          hintText: '플로우 설명을 입력해주세요.',
          label: '플로우 설명',
          isMultiLine: true,
          onChanged: (v) {
            ref.read(flowFormProvider.notifier).update(description: v);
          },
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    super.key,
    this.isSelected = false,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: isSelected ? const Color(0xFF3f73ff) : const Color(0xFFddefff),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: SHFlowTextStyle.subTitle.copyWith(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
