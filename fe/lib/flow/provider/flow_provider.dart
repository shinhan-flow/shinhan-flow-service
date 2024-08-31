import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/model/flow_model.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/repository/flow_repository.dart';
import 'package:shinhan_flow/flow/view/flow_init_screen.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../../common/param/pagination_param.dart';
import '../../common/provider/pagination_provider.dart';
import '../param/flow_param.dart';

part 'flow_provider.g.dart';

@riverpod
Future<BaseModel> createFlow(CreateFlowRef ref) async {
  final param = ref.read(flowFormProvider);
  final repository = ref.read(flowRepositoryProvider);
  return await repository
      .createFlow(param: param)
      .then<BaseModel>((value) async {
    logger.i(value);
    final flowId = ref.read(flowIdProvider);
    if (flowId != null) {
      ref.read(deleteFlowProvider(flowId: flowId));
    }
    ref.invalidate(flowProvider);

    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}

@riverpod
class FlowDetail extends _$FlowDetail {
  @override
  BaseModel build({required int id}) {
    get(flowId: id);
    return LoadingModel();
  }

  void get({required int flowId}) async {
    await ref
        .read(flowRepositoryProvider)
        .getFlow(flowId: flowId)
        .then((value) async {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}

@riverpod
Future<BaseModel> toggleFlow(ToggleFlowRef ref, {required int flowId}) async {
  final repository = ref.read(flowRepositoryProvider);
  return await repository
      .toggleFlow(flowId: flowId)
      .then<BaseModel>((value) async {
    logger.i(value);
    final provider = ref.read(flowProvider);
    final models = provider as ResponseModel<PaginationModel<FlowModel>>;
    final list = models.data!.pageContent;
    // final flow = list.firstWhere((l) => l.id == flowId);
    // final newFlow = flow.copyWith(enable: !flow.enable);
    //
    // int findIdx = list.indexWhere((l)=>l.id == flowId);

    final newPageContent = list.map((l) {
      if (l.id == flowId) {
        return l.copyWith(enable: !l.enable);
      }
      return l;
    }).toList();

    final newProvider = provider.data!.copyWith(pageContent: newPageContent);
    final contents = ResponseModel(code: '', message: '', data: newProvider);
    ref.read(flowProvider.notifier).update(contents: contents);

    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}

@riverpod
Future<BaseModel> deleteFlow(DeleteFlowRef ref, {required int flowId}) async {
  final repository = ref.read(flowRepositoryProvider);
  return await repository
      .deleteFlow(flowId: flowId)
      .then<BaseModel>((value) async {
    logger.i(value);
    final provider = ref.read(flowProvider);
    final models = provider as ResponseModel<PaginationModel<FlowModel>>;
    final list = models.data!.pageContent;

    final newPageContent = list
      ..removeWhere((l) => l.id == flowId)
      ..toList();

    final newProvider = provider.data!.copyWith(pageContent: newPageContent);
    final contents = ResponseModel(code: '', message: '', data: newProvider);
    ref.read(flowProvider.notifier).update(contents: contents);

    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}

final flowProvider =
    StateNotifierProvider.autoDispose<FlowStateNotifier, BaseModel>((ref) {
  final repository = ref.watch(flowPRepositoryProvider);
  return FlowStateNotifier(
    repository: repository,
    pageParams: const PaginationParam(
      nowPage: 0,
      perPage: 5,
    ),
  );
});

class FlowStateNotifier
    extends PaginationProvider<FlowModel, FlowPParam, FlowPRepository> {
  FlowStateNotifier({
    required super.repository,
    required super.pageParams,
    super.param,
    super.path,
  });

  void update({required ResponseModel<PaginationModel<FlowModel>> contents}) {
    state = contents;
  }
}
