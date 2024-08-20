import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/flow_category.dart';

final flowCategoryProvider = StateProvider.autoDispose<Set<FlowCategoryType>>((ref) => {});
