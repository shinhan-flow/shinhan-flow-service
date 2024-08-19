
import 'package:riverpod/riverpod.dart';

import '../logger/custom_logger.dart';

class CustomProviderObserver extends ProviderObserver{
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    logger.t('Init Provider = $provider');
  }
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    logger.t('Update Provider = $provider, $previousValue => $newValue');
  }
  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    logger.t('Dispose Provider = $provider');
    super.didDisposeProvider(provider, container);
  }
}