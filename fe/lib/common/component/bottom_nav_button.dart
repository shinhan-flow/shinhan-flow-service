import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavButton extends StatelessWidget {
  final Widget child;

  const BottomNavButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}
