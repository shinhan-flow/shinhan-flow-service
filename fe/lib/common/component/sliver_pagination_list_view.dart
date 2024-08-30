import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shinhan_flow/theme/text_theme.dart';

import '../model/default_model.dart';
import '../param/pagination_param.dart';
import '../provider/pagination_provider.dart';

enum ScrollDirection { horizontal, vertical }

typedef PaginationWidgetBuilder<T extends Base> = Widget Function(
    BuildContext context, int index, T model);

class DisposeSliverPaginationListView<T extends Base, S>
    extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<PaginationProvider, BaseModel>
  provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final S? param;
  final Widget skeleton;
  final double separateSize;
  final ScrollController controller;
  final Widget emptyWidget;

  const DisposeSliverPaginationListView({
    required this.provider,
    required this.itemBuilder,
    required this.skeleton,
    required this.controller,
    this.param,
    this.separateSize = 16,
    required this.emptyWidget,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DisposeSliverPaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends Base>
    extends ConsumerState<DisposeSliverPaginationListView> {
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    // widget.controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // log("scrolling!!");
    // final family = widget.provider.argument as PaginationStateParam;

    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent) {
      // log("scroll end");
      ref.read(widget.provider.notifier).paginate(
        paginationParams:  const PaginationParam(nowPage: 0, perPage: 5),
        param: widget.param,
        fetchMore: true,
        // path: family.path,
      );
      // 스크롤이 끝에 도달했을 때 새로운 항목 로드
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 완전 처음 로딩일때
    if (state is LoadingModel) {
      return SliverToBoxAdapter(
        child: widget.skeleton,
      ); // todo 스켈레톤 일반화
    }
    // 에러
    if (state is ErrorModel) {
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '일시적으로 화면을 불러올 수 없습니다.\n잠시후 다시 이용해주세요.',
              style: SHFlowTextStyle.subTitle,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                '뒤로가기',
              ),
            ),
          ],
        ),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    final cp = state as ResponseModel<PaginationModel<T>>;
    if (state.data!.pageContent.isEmpty) {
      return SliverFillRemaining(child: widget.emptyWidget);
    }
    return SliverList.separated(
      itemCount: cp.data!.pageContent.length + 1,
      itemBuilder: (_, index) {
        if (index == (cp.data!.pageContent.length)) {
          if (cp is! ResponseModel<PaginationModelFetchingMore>) {
            WidgetsBinding.instance.addPostFrameCallback((_) {});
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Center(
              child: cp is ResponseModel<PaginationModelFetchingMore>
                  ? const CircularProgressIndicator()
                  : Container(),
            ),
          );
        }

        final pItem = cp.data!.pageContent[index];

        return widget.itemBuilder(
          context,
          index,
          pItem,
        );
      },
      separatorBuilder: (_, index) {
        return SizedBox(
          height: widget.separateSize.h,
          width: widget.separateSize.w,
        );
      },
    );
  }
}