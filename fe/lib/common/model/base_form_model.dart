import '../../flow/param/trigger/trigger_param.dart';
import '../param/default_param.dart';

mixin BaseFormModel {
  bool valid = false;

  DefaultParam toParam();
}
