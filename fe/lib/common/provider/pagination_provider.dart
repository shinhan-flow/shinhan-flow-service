import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/default_model.dart';
import '../param/default_param.dart';
import '../param/pagination_param.dart';
import '../repository/base_pagination_repository.dart';

class PaginationProvider<T extends Base, S extends DefaultParam,
        U extends IBasePaginationRepository<T, S>>
    extends StateNotifier<BaseModel> {
  final U repository;
  final PaginationParam pageParams;
  final S? param;
  final int? path;

  PaginationProvider({
    required this.repository,
    required this.pageParams,
    this.param,
    this.path,
  }) : super(LoadingModel()) {
    log("pagination Provider init");
    log("param ${param}");
    paginate(
      paginationParams: pageParams,
      param: param,
      path: path,
    );
  }

  Future<void> paginate(
      {required PaginationParam paginationParams,
      S? param,
      int? path,
      bool fetchMore = false,
      bool forceRefetch = false}) async {
    try {
      log('prev state type = ${state.runtimeType}');

      if (state is ResponseModel<PaginationModel> && !forceRefetch) {
        final pState = (state as ResponseModel<PaginationModel>).data!;
        // 다음 페이지가 없을 경우
        if (pState.totalPage - 1 == pState.nowPage) {
          log('다음 페이지가 없을 경우');
          return;
        }
      }
      final isLoading = state is LoadingModel;
      final isRefetching = state is ResponseModel<PaginationModelRefetching>;
      final isFetchingMore =
          state is ResponseModel<PaginationModelFetchingMore>;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      log("fetchMore = $fetchMore");
      if (fetchMore) {
        final pState = state as ResponseModel<PaginationModel<T>>;
        state = ResponseModel(
            code: pState.code,
            message: pState.message,
            data: PaginationModelFetchingMore<T>(
                totalPage: pState.data!.totalPage,
                nowPage: pState.data!.nowPage + 1,
                pageContent: pState.data!.pageContent));

        paginationParams =
            paginationParams.copyWith(page: pState.data!.nowPage + 1);
      } else {
        if (state is ResponseModel<PaginationModel> && !forceRefetch) {
          final pState = state as ResponseModel<PaginationModel<T>>;
          state = ResponseModel(
              code: pState.code,
              message: pState.message,
              data: PaginationModelRefetching<T>(
                  nowPage: pState.data!.nowPage,
                  totalPage: pState.data!.totalPage,
                  pageContent: pState.data!.pageContent));
        } else {
          state = LoadingModel();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
        param: param,
        path: path,
      );
      log("resp type = ${resp.runtimeType}");
      log("mid state type = ${state.runtimeType} ");
      if (state is ResponseModel<PaginationModelFetchingMore>) {
        final pState = state as ResponseModel<PaginationModelFetchingMore<T>>;
        final data = pState.data!.copyWith(pageContent: [
          ...pState.data!.pageContent,
          ...resp.data!.pageContent,
        ]);

        state = resp.copyWith(
          data: data,
        );
        log("change state type = ${state.runtimeType} ");
      } else {
        state = resp;
      }
      log("after state type = ${state.runtimeType} ");
    } catch (e, stack) {
      log("pagination error = $e}");
      log("pagination stack = $stack}");
      state = ErrorModel.respToError(e);
    }
  }
}
