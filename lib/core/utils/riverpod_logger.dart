import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';

final class RiverpodLogger extends ProviderObserver {

  @override
  void didUpdateProvider(
      ProviderObserverContext context,
      Object? previousValue,
      Object? newValue,
      ) {
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType.toString();

    AppLogger.debug(
      'State Updated: $previousValue -> $newValue',
      tag: 'Riverpod: $providerName',
    );
  }

  @override
  void didAddProvider(
      ProviderObserverContext context,
      Object? value,
      ) {
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType.toString();

    AppLogger.info(
      'Initialized with value: $value',
      tag: 'Riverpod: $providerName',
    );
  }

  @override
  void didDisposeProvider(
      ProviderObserverContext context,
      ) {
    final provider = context.provider;
    final providerName = provider.name ?? provider.runtimeType.toString();

    AppLogger.warning(
      'Disposed',
      tag: 'Riverpod: $providerName',
    );
  }
}