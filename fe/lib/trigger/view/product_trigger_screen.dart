import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/common/component/default_appbar.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/provider/widget/product_trigger_form_provider.dart';

import '../../common/component/bottom_nav_button.dart';
import '../../common/component/default_text_button.dart';
import '../../common/component/text_input_form.dart';
import '../../flow/param/trigger/trigger_param.dart';
import '../../theme/text_theme.dart';
import '../model/enum/product_property.dart';

class ProductTriggerScreen extends StatelessWidget {
  static String get routeName => "product";

  const ProductTriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onPanDown: (v) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final valid = ref.watch(tgProductFormProvider).valid;

            return BottomNavButton(
              child: DefaultTextButton(
                onPressed: valid
                    ? () {
                        final trigger = ref.read(tgProductFormProvider);

                        ref.read(flowFormProvider.notifier).addTrigger(
                            trigger: trigger.toParam() as TriggerBaseParam);
                        context.pop();
                      }
                    : null,
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
                  isSliver: true,
                  title: '상품 조건 설정',
                )
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _ProductForm(),
                )
              ],
            )),
      ),
    );
  }
}

class _ProductForm extends ConsumerStatefulWidget {
  const _ProductForm({super.key});

  @override
  ConsumerState<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<_ProductForm> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(tgProductFormProvider, (prev, next) {
      if (prev?.accountProduct != next.accountProduct) {
        textEditingController.clear();
      }
    });
    final form = ref.watch(tgProductFormProvider);

    final filters = AccountProductType.values
        .map((a) => _ProductTriggerFilter(
              isSelected: form.accountProduct == a,
              property: a,
              onTap: () {
                ref.read(tgProductFormProvider.notifier).update(property: a);
              },
            ))
        .toList();

    return Padding(
      padding: EdgeInsets.all(25.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '상품 조건',
            style: SHFlowTextStyle.subTitle,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: filters,
          ),
          SizedBox(height: 24.h),
          Text('${form.accountProduct?.name ?? '상품'} 금리',
              style: SHFlowTextStyle.subTitle),
          SizedBox(height: 8.h),
          CustomTextFormField(
            textEditingController: textEditingController,
            hintText: '${form.accountProduct?.name ?? '상품'} 금리를 입력해주세요.',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r"^\d?\.?\d{0,2}"),
                  allow: true),
              // FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (v) {
              ref.read(tgProductFormProvider.notifier).update(
                  property: form.accountProduct,
                  interestRate: v.isNotEmpty ? double.parse(v) : null);
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _ProductTriggerFilter extends StatelessWidget {
  final AccountProductType property;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProductTriggerFilter({
    super.key,
    required this.isSelected,
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
