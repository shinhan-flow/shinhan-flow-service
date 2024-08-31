import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/home_screen.dart';
import 'package:shinhan_flow/prompt/param/prompt_param.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../repository/prompt_repository.dart';

part 'prompt_provider.g.dart';

@riverpod
Future<BaseModel> prompt(PromptRef ref) async {
  final prompt = ref.read(promptInputProvider);

  final promptParam = PromptParam(input_string: prompt);
  return await ref
      .watch(promptRepositoryProvider)
      .getPrompt(prompt: promptParam)
      .then<BaseModel>((value) async {
    logger.i('prompt $value!');
    final model = value;
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('code ${error.code}\nmessage = ${error.message}');
    return error;
  });
}
