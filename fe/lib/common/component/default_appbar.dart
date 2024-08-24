import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final PreferredSizeWidget? bottom;
  final bool isSliver;
  final List<Widget>? actions;
  final Color? backgroundColor;

  // final String leadingIcon;
  final Widget? leading;
  final bool hasBorder;

  const DefaultAppBar({
    super.key,
    this.title,
    this.bottom,
    this.isSliver = false,
    this.actions,
    this.backgroundColor,
    // this.leadingIcon = "back_arrow",
    this.hasBorder = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    // log('context.canPop() = ${context.canPop()}');
    if (isSliver) {
      return SliverAppBar(
        title: Text(
          title ?? '',
          style: SHFlowTextStyle.appbar.copyWith(
              // color: MITIColor.white,
              ),
        ),
        leadingWidth:
            leading == null ? null : MediaQuery.of(context).size.width / 2,

        backgroundColor: backgroundColor ?? Colors.white,

        /// 앱바 pinned 시 surface 컬러
        surfaceTintColor: backgroundColor ?? Colors.white,
        shape: hasBorder
            ? const Border(
                bottom: BorderSide(color: Color(0xFFDFDFDF)),
              )
            : null,
        centerTitle: true,
        leading: leading,
        bottom: bottom,
        actions: actions,
        pinned: true,
      );
    }
    return AppBar(
      shape: hasBorder
          ? const Border(
              bottom: BorderSide(color: Color(0xFFDFDFDF)),
            )
          : null,
      title: Text(
        title ?? '',
        style: SHFlowTextStyle.appbar.copyWith(
            // color: MITIColor.white,
            ),
      ),
      backgroundColor: backgroundColor ?? Colors.white,

      /// 앱바 pinned 시 surface 컬러
      surfaceTintColor: backgroundColor ?? Colors.white,
      centerTitle: true,
      leading: leading,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom != null ? 44.h : 0;
    return Size.fromHeight(44.h + bottomHeight);
  }
}
