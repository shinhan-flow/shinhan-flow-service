import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/common/component/default_text_button.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? initialValue;
  final String? label;
  final String hintText;
  final bool obscureText;
  final bool enable;
  final ValueChanged<String>? onChanged;
  final bool isMultiLine;
  final TextInputType? keyboardType;
  final Widget? side;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.label,
    this.obscureText = false,
    this.onChanged,
    this.side,
    this.initialValue,
    this.enable = true,
    this.isMultiLine = false,
    this.keyboardType,
    this.inputFormatters,
    this.textEditingController,
  });

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
        Row(
          children: [
            Expanded(
              /// constraints 으로 크기를 지정해도 align을 지정 안하면 안됨!
              child: TextFormField(
                controller: textEditingController,
                obscuringCharacter: '●',
                obscureText: obscureText,
                onChanged: onChanged,
                initialValue: initialValue,
                enabled: enable,
                autofocus: false,
                maxLines: isMultiLine ? null : 1,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                // expands: true,
                decoration: InputDecoration(
                  constraints:
                      BoxConstraints(maxHeight: 200.h, minHeight: 48.h),
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
                  prefixIconConstraints: BoxConstraints.loose(
                    Size(double.infinity, 36.h),
                  ),
                  suffixIconConstraints: BoxConstraints.loose(
                    Size(double.infinity, 36.h),
                  ),
                ),
              ),
            ),
            if (side != null)
              Align(
                child: Row(
                  children: [
                    SizedBox(width: 12.w),
                    side!,
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
