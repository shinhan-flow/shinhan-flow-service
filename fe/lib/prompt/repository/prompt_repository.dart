import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinhan_flow/prompt/param/prompt_param.dart';

import '../../common/model/default_model.dart';
import '../../dio/dio_interceptor.dart';
import '../../dio/provider/dio_provider.dart';
import 'dart:convert' show jsonEncode;

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../flow/model/flow_model.dart';

part 'prompt_repository.g.dart';

final promptRepositoryProvider = Provider<PromptRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = PromptRepository(dio);
  return repository;
});

@RestApi(baseUrl: serverURL)
abstract class PromptRepository {
  factory PromptRepository(Dio dio, {ParseErrorLogger errorLogger}) =
      _PromptRepository;

  @Headers({'token': 'true'})
  @POST('/api/v1/ai/flow-generator')
  Future<ResponseModel<FlowDetailModel>> getPrompt({
    @Body() required PromptParam prompt,

});
}
