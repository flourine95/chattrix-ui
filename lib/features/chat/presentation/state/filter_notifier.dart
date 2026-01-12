import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_notifier.g.dart';

@Riverpod(keepAlive: true)
class FilterNotifier extends _$FilterNotifier {
  @override
  ConversationFilter build() {
    return ConversationFilter.all;
  }

  void setFilter(ConversationFilter filter) {
    state = filter;
  }
}
