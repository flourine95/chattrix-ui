import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_notifier.g.dart';

/// Notifier for managing conversation filter state
///
/// **State**: ConversationFilter (all, unread, groups)
/// **Lifecycle**: keepAlive (persists during session)
///
/// **Requirements**: 2.1, 2.2, 2.3, 2.4
@Riverpod(keepAlive: true)
class FilterNotifier extends _$FilterNotifier {
  @override
  ConversationFilter build() {
    AppLogger.debug('🏗️ Building FilterNotifier with default filter: all', tag: 'FilterNotifier');
    return ConversationFilter.all;
  }

  /// Set the current filter
  ///
  /// **Parameters:**
  /// - [filter]: The filter to apply (all, unread, groups)
  ///
  /// **Requirements**: 2.1, 2.2, 2.3, 2.4
  void setFilter(ConversationFilter filter) {
    AppLogger.info('🔄 Setting filter to: $filter', tag: 'FilterNotifier');
    state = filter;
  }

  /// Get the current filter
  ///
  /// **Returns**: Current ConversationFilter
  ConversationFilter get currentFilter {
    return state;
  }
}
