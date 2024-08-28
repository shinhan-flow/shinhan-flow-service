import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/flow/provider/widget/flow_form_provider.dart';
import 'package:shinhan_flow/flow/repository/flow_repository.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';

part 'flow_provider.g.dart';

@riverpod
Future<BaseModel> createFlow(CreateFlowRef ref) async {
  final param = ref.read(flowFormProvider);
  final repository = ref.read(flowRepositoryProvider);
  return await repository.createFlow(param: param).then<BaseModel>((value) async {
    logger.i(value);
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}

