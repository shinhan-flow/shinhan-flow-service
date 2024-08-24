import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/theme/text_theme.dart';
import 'package:shinhan_flow/trigger/model/enum/foreign_currency_category.dart';

class DropDownButton extends StatelessWidget {
  final String? value;
  final ValueChanged<String?>? onChanged;

  const DropDownButton({super.key, this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    final foreign = ForeignCurrencyCategory.values.map((f) => f.displayName).toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        // isDense: true,
        style: SHFlowTextStyle.labelSmall.copyWith(color: Colors.black),
        items: foreign
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                    ),
                  ),
                ))
            .toList(),
        value: value ?? foreign[0],
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.only(left: 16.w, right: 4.w),
          // padding: EdgeInsets.all(widget.padding ?? 8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: const Color(0xFFD0DBE5),
          ),
          height: 32.h,
          width: 120.w,
        ),
        iconStyleData: IconStyleData(
            icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 16.r,
        )),
        dropdownStyleData: DropdownStyleData(
            // scrollPadding: EdgeInsets.only(top: 4.h),
            // width: 85.w,
            offset: Offset(0, -4.h),
            elevation: 0,
            maxHeight: MediaQuery.of(context).size.height < 600.h
                ? MediaQuery.of(context).size.height - 200.h
                : 300.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFD0DBE5),
            )),
        menuItemStyleData: MenuItemStyleData(
          // overlayColor: WidgetStateProperty.all(const Color(0xFF404040)),
          height: 32.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        ),
      ),
    );
  }
}
