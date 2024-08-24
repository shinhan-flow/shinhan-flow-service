import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class DefaultTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool able;
  final bool stretch;

  const DefaultTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.able,
    this.stretch = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: able ? onPressed : null,
      style: TextButton.styleFrom(
        minimumSize: stretch ? Size(double.infinity, 48.h) : null,
        maximumSize: stretch ? Size(double.infinity, 48.h) : null,
        backgroundColor:
            able ? const Color(0xFF0057FF) : const Color(0xFFcbcfd7),
      ),
      child: Text(
        text,
        style: SHFlowTextStyle.button.copyWith(
          color: able ? Colors.white : const Color(0xFF525252),
        ),
      ),
    );
  }
}
