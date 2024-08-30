import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../repository/member_repository.dart';

part 'member_provider.g.dart';

@riverpod
class MemberInfo extends _$MemberInfo {
  @override
  BaseModel build() {
    get();
    return LoadingModel();
  }

  Future<void> get() async {
    final repository = ref.watch(memberRepositoryProvider);
    await repository.getMemberInfo().then((value) {
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
class MemberCreditScore extends _$MemberCreditScore {
  @override
  BaseModel build() {
    get();
    return LoadingModel();
  }

  Future<void> get() async {
    final repository = ref.watch(memberRepositoryProvider);
    await repository.getCreditScore().then((value) {
      logger.i(value);
      state = value;
    }).catchError((e) {
      final error = ErrorModel.respToError(e);
      logger.e('code ${error.code}\nmessage = ${error.message}');
      state = error;
    });
  }
}
