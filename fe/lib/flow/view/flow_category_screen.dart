import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/flow/provider/flow_category_provider.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../model/flow_category.dart';

class FlowCategoryScreen extends ConsumerWidget {
  static String get routeName => 'flowCategory';

  const FlowCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategories = ref.watch(flowCategoryProvider);
    final cards = FlowCategoryType.values
        .map((v) => _CategoryCard(
              onTap: () {
                if (selectedCategories.add(v)) {
                  ref
                      .read(flowCategoryProvider.notifier)
                      .update((v) => selectedCategories.toSet());
                } else {
                  selectedCategories.remove(v);
                }
                ref
                    .read(flowCategoryProvider.notifier)
                    .update((v) => selectedCategories.toSet());
              },
              name: v.name,
              isSelected: selectedCategories.contains(v),
            ))
        .toList();
    return Scaffold(
      bottomNavigationBar: Container(
        constraints: BoxConstraints.tight(Size(
          double.infinity,
          91.h,
        )),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFDFDFDF)),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 16.h),
        child: DefaultTextButton(
          onPressed: () {},
          text: '다음',
          able: selectedCategories.isNotEmpty,
        ),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              DefaultAppBar(
                isSliver: true,
                title: '조건 카테고리',
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24.h, top: 30.h),
                    child: Text(
                      '조건 카테고리를 선택해주세요!',
                      style: SHFlowTextStyle.subTitle,
                    ),
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (_, idx) {
                    return cards[idx];
                  },
                  separatorBuilder: (_, idx) => SizedBox(height: 21.h),
                  itemCount: cards.length,
                ),
              ],
            ),
          )),
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
    return InkWell(
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
