import 'dart:async';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/domain/entities/search_user.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_usecase_provider.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchUsersPage extends HookConsumerWidget {
  const SearchUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final searchController = useTextEditingController();
    final searchQuery = useState("");
    final isSearching = useState(false);
    final searchResults = useState<List<SearchUser>>([]);
    final searchError = useState<String?>(null);
    final debounceTimer = useRef<Timer?>(null);

    Future<void> performSearch(String query) async {
      if (query.trim().isEmpty) {
        searchResults.value = [];
        searchError.value = null;
        return;
      }
      
      debugPrint('🔍 [SearchUsers] Searching for: "$query"');
      isSearching.value = true;
      searchError.value = null;
      
      try {
        final searchUsecase = ref.read(searchUsersUsecaseProvider);
        debugPrint('📡 [SearchUsers] Calling API...');
        final result = await searchUsecase(query: query, limit: 50);
        
        result.fold(
          (failure) {
            debugPrint('❌ [SearchUsers] Search failed: ${failure.message}');
            searchError.value = failure.message;
            searchResults.value = [];
          },
          (users) {
            debugPrint('✅ [SearchUsers] Search success: Found ${users.length} users');
            searchResults.value = users;
          },
        );
      } catch (e) {
        debugPrint('❌ [SearchUsers] Exception: $e');
        searchError.value = 'An error occurred: $e';
        searchResults.value = [];
      } finally {
        isSearching.value = false;
      }
    }

    useEffect(() {
      searchController.addListener(() {
        final query = searchController.text;
        searchQuery.value = query;
        
        // Cancel previous timer
        debounceTimer.value?.cancel();
        
        // Set new timer for debounce (500ms)
        debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
          performSearch(query);
        });
      });
      
      return () {
        debounceTimer.value?.cancel();
      };
    }, []);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Users',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name or username...',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      Icons.search,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      size: 20,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 20,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            size: 18,
                          ),
                          onPressed: () {
                            searchController.clear();
                            searchQuery.value = "";
                            searchResults.value = [];
                            searchError.value = null;
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
          // Divider
          Container(
            height: 0.5,
            color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
          ),
          // Results
          Expanded(
            child: isSearching.value
                ? const Center(child: CircularProgressIndicator())
                : searchError.value != null
                    ? _buildErrorState(isDark, searchError.value!)
                    : searchQuery.value.isEmpty
                        ? _buildInitialState(isDark)
                        : searchResults.value.isEmpty
                            ? _buildNoResultsState(isDark)
                            : _buildSearchResults(ref, searchResults.value, isDark, colors),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Find Friends',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Search by name or username\nto find and add friends',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No users found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(bool isDark, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: isDark ? Colors.red[300] : Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'Search Failed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(WidgetRef ref, List<SearchUser> results, bool isDark, ColorScheme colors) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Container(
        height: 0.5,
        margin: const EdgeInsets.only(left: 72),
        color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
      ),
      itemBuilder: (context, index) {
        final user = results[index];
        return _UserSearchResultItem(
          user: user,
          isDark: isDark,
          colors: colors,
        );
      },
    );
  }
}

class _UserSearchResultItem extends ConsumerWidget {
  final SearchUser user;
  final bool isDark;
  final ColorScheme colors;

  const _UserSearchResultItem({
    required this.user,
    required this.isDark,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactState = ref.watch(contactProvider);
    
    // Check if already friend using isContact from SearchUser
    final isAlreadyFriend = user.isContact;
    
    // Check if request already sent
    final requestAlreadySent = contactState.sentRequests.any((r) => r.receiverUserId == user.id);

    return InkWell(
      onTap: isAlreadyFriend ? () {
        // TODO: Navigate to chat or user profile
        debugPrint('Tapped on friend: ${user.fullName}');
      } : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            UserAvatar(
              displayName: user.fullName,
              avatarUrl: user.avatarUrl,
              radius: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isAlreadyFriend)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // TODO: Start audio call
                      debugPrint('Audio call to ${user.fullName}');
                    },
                    icon: Icon(
                      Icons.phone,
                      color: colors.primary,
                      size: 22,
                    ),
                    tooltip: 'Audio call',
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Start video call
                      debugPrint('Video call to ${user.fullName}');
                    },
                    icon: Icon(
                      Icons.videocam,
                      color: colors.primary,
                      size: 22,
                    ),
                    tooltip: 'Video call',
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Navigate to chat
                      debugPrint('Message to ${user.fullName}');
                    },
                    icon: Icon(
                      Icons.message,
                      color: colors.primary,
                      size: 22,
                    ),
                    tooltip: 'Message',
                  ),
                ],
              )
            else if (requestAlreadySent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pending',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ),
              )
            else
              SizedBox(
                width: 70,
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint('🔔 Sending friend request to user ${user.id}');
                    final success = await ref.read(contactProvider.notifier).sendFriendRequest(
                          receiverUserId: user.id,
                        );
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Friend request sent!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (context.mounted) {
                      final error = ref.read(contactProvider).errorMessage ?? 'Failed to send request';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(70, 36),
                  ),
                  child: const Text('Add', style: TextStyle(fontSize: 13)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
