import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.label,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Text(
            label!,
            style:
                SHFlowTextStyle.label.copyWith(color: const Color(0xFF515151)),
          ),
        if (label != null) SizedBox(height: 8.h),
        TextFormField(
          obscuringCharacter: '●',
          obscureText: obscureText,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            // isDense: false,
            // isCollapsed:true,

            constraints: BoxConstraints(maxHeight: 48.h, minHeight: 48.h),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            // hintStyle: hintTextStyle ??
            //     MITITextStyle.md.copyWith(
            //       color: MITIColor.gray500,
            //     ),
            // fillColor: MITIColor.gray700,
            // filled: true,
            // prefixIcon: prefix == null
            //     ? null
            //     : Padding(
            //         padding: EdgeInsets.only(left: prefix == null ? 0 : 20.w),
            //         child: prefix,
            //       ),
            prefixIconConstraints: BoxConstraints.loose(
              Size(double.infinity, 36.h),
            ),
            // suffixIcon: Padding(
            //   padding: EdgeInsets.only(right: suffixIcon == null ? 0 : 20.w),
            //   child: suffixIcon,
            // ),
            suffixIconConstraints: BoxConstraints.loose(
              Size(double.infinity, 36.h),
            ),
          ),
        ),
      ],
    );
  }
}
