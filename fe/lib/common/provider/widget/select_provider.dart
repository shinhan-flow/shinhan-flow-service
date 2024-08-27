import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectProvider =
    StateProvider.family.autoDispose<bool, int>((ref, id) => false);
