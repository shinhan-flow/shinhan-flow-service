import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/auth/provider/auth_provider.dart';
import 'package:shinhan_flow/auth/provider/widget/widget/login_form_provider.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../../common/provider/secure_storage_provider.dart';
import '../param/login_param.dart';
import '../repository/auth_repository.dart';

part 'login_provider.g.dart';

@riverpod
Future<BaseModel> login(LoginRef ref) async {
  // final fcmToken = ref.read(fcmTokenProvider)!;
  // print("login fcm_token ${fcmToken}");
  final form = ref.read(loginFormProvider);
  final param = form.toParam() as LoginParam;

  return await ref
      .watch(authRepositoryProvider)
      .login(username: param.email, password: param.password)
      .then<BaseModel>((value) async {
    logger.i('login $param!');
    final model = value.data!;
    final storage = ref.read(secureStorageProvider);

    await storage.write(key: 'accessToken', value: model.access);
    await storage.write(key: 'refreshToken', value: model.refresh);
    // await saveUserInfo(storage, model, ref);
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e('status_code = ${error.code}\nmessage = ${error.message}');
    return error;
  });
}
