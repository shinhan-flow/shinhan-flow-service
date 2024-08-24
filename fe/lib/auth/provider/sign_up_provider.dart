import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shinhan_flow/auth/provider/widget/widget/sign_up_form_provider.dart';

import '../../common/logger/custom_logger.dart';
import '../../common/model/default_model.dart';
import '../../common/provider/secure_storage_provider.dart';
import '../param/sign_up_param.dart';
import '../repository/auth_repository.dart';

part 'sign_up_provider.g.dart';

@riverpod
Future<BaseModel> signUp(SignUpRef ref) async {
  // final fcmToken = ref.read(fcmTokenProvider)!;
  // print("login fcm_token ${fcmToken}");
  final form = ref.read(signUpFormProvider);
  final param = form.toParam() as SignUpParam;

  return await ref
      .watch(authRepositoryProvider)
      .signUp(
        username: param.email,
        password: param.password,
        name: param.name,
      )
      .then<BaseModel>((value) async {
    logger.i('signUp $param!');
    // final model = value.data!;
    final storage = ref.read(secureStorageProvider);

    // storage.write(key: 'accessToken', value: );
    // await saveUserInfo(storage, model, ref);
    return value;
  }).catchError((e) {
    final error = ErrorModel.respToError(e);
    logger.e(
        'status_code = ${error.statusCode}\nerror.error_code = ${error.errorCode}\nmessage = ${error.message}\ndata = ${error.data}');
    return error;
  });
}
