import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shinhan_flow/flow/model/enum/action_category.dart';

import '../model/enum/trigger_category.dart';

final triggerCategoryProvider =
    StateProvider.autoDispose<Set<TriggerCategoryType>>((ref) => {});


final actionCategoryProvider =
StateProvider.autoDispose<Set<ActionCategoryType>>((ref) => {});
