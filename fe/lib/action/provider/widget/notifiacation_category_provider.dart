import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinhan_flow/action/model/enum/action_type.dart';

final notificationCategoryProvider =
    StateProvider.autoDispose<ActionType?>((ref) => null);
