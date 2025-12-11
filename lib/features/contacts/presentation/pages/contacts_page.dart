import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// --- ENTITY MOCK ---
class ContactEntity {
  final String id;
  final String name;
  final String? avatarUrl;
  final String status;
  final bool isOnline;
  ContactEntity({required this.id, required this.name, this.avatarUrl, required this.status, this.isOnline = false});
}

class GroupEntity {
  final String id;
  final String name;
  final int memberCount;
  GroupEntity({required this.id, required this.name, required this.memberCount});
}

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  // 1. Quản lý từ khóa tìm kiếm tại Parent
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.surface, // Đổi nền chính thành surface cho liền mạch
        appBar: AppBar(
          title: Text(
            'Contacts',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: colors.surface,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_add_alt_1_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            // --- 2. SEARCH BAR DÙNG CHUNG ---
            Container(
              color: colors.surface,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  // Cập nhật state để truyền xuống các tab con
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search friends or groups...',
                  prefixIcon: Icon(Icons.search, color: colors.outline),
                  filled: true,
                  fillColor: colors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  // Thêm nút clear text khi đang gõ
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = "");
                    },
                  )
                      : null,
                ),
              ),
            ),

            // --- 3. TAB BAR ---
            Container(
              color: colors.surface,
              child: TabBar(
                labelColor: colors.primary,
                unselectedLabelColor: colors.onSurfaceVariant,
                indicatorColor: colors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: colors.outlineVariant.withValues(alpha: 0.5),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                tabs: const [
                  Tab(text: "Friends"),
                  Tab(text: "Groups"),
                ],
              ),
            ),

            // --- 4. TAB VIEW (Truyền query xuống) ---
            Expanded(
              child: Container(
                color: colors.surfaceContainerLow, // Màu nền xám nhạt cho phần list
                child: TabBarView(
                  children: [
                    _FriendsTab(searchQuery: _searchQuery), // Truyền query
                    _GroupsTab(searchQuery: _searchQuery),  // Truyền query
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 1: FRIENDS TAB (Có logic lọc)
// =============================================================================
class _FriendsTab extends StatelessWidget {
  final String searchQuery; // Nhận từ khoá tìm kiếm
  const _FriendsTab({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Mock Data
    final List<ContactEntity> allContacts = [
      ContactEntity(id: '1', name: 'An Nguyen', status: 'Mobile Developer', isOnline: true),
      ContactEntity(id: '2', name: 'Binh Tran', status: 'Sleeping...', isOnline: false),
      ContactEntity(id: '3', name: 'Cuong Le', status: 'At work', isOnline: true),
      ContactEntity(id: '4', name: 'David Beo', status: 'Gym', isOnline: false),
    ];

    // Logic Lọc (Filter)
    final filteredContacts = allContacts.where((contact) {
      return contact.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // Logic Grouping A-Z (Chạy trên list đã lọc)
    final Map<String, List<ContactEntity>> groupedContacts = {};
    for (var contact in filteredContacts) {
      final String firstLetter = contact.name[0].toUpperCase();
      if (!groupedContacts.containsKey(firstLetter)) groupedContacts[firstLetter] = [];
      groupedContacts[firstLetter]!.add(contact);
    }
    final sortedKeys = groupedContacts.keys.toList()..sort();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          // Chỉ hiện mục Friend Request nếu KHÔNG tìm kiếm
          if (searchQuery.isEmpty)
            _SectionCard(
              colors: colors,
              children: [
                _MenuTile(
                  icon: FontAwesomeIcons.userGroup,
                  label: 'Friend Requests',
                  colors: colors,
                  textTheme: textTheme,
                  badgeCount: 3,
                )
              ],
            ),

          if (searchQuery.isEmpty) const SizedBox(height: 24),

          if (filteredContacts.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text("No friends found", style: TextStyle(color: colors.outline)),
            )
          else
            ...sortedKeys.map((key) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32, bottom: 8),
                  child: Text(key, style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold)),
                ),
                _SectionCard(
                  colors: colors,
                  children: groupedContacts[key]!.map((c) => _ContactTile(contact: c, colors: colors, textTheme: textTheme)).toList(),
                ),
                const SizedBox(height: 16),
              ],
            )),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: GROUPS TAB (Có logic lọc)
// =============================================================================
class _GroupsTab extends StatelessWidget {
  final String searchQuery;
  const _GroupsTab({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<GroupEntity> allGroups = [
      GroupEntity(id: '1', name: 'Flutter Devs VN', memberCount: 1540),
      GroupEntity(id: '2', name: 'Family ❤️', memberCount: 6),
      GroupEntity(id: '3', name: 'Project Chattrix', memberCount: 4),
    ];

    // Logic Lọc
    final filteredGroups = allGroups.where((group) {
      return group.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          // Nút tạo nhóm chỉ hiện khi không tìm kiếm
          if (searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("Create New Group"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                ),
              ),
            ),

          if (filteredGroups.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text("No groups found", style: TextStyle(color: colors.outline)),
            )
          else
            _SectionCard(
              colors: colors,
              children: filteredGroups.map((group) => ListTile(
                leading: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.groups, color: colors.onPrimaryContainer),
                ),
                title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${group.memberCount} members'),
                trailing: Icon(Icons.chevron_right, color: colors.outline),
              )).toList(),
            ),
        ],
      ),
    );
  }
}

// --- REUSABLE COMPONENTS (Giữ nguyên) ---
class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  final ColorScheme colors;
  const _SectionCard({required this.children, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Column(children: children)),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon; final String label; final ColorScheme colors; final TextTheme textTheme; final int badgeCount;
  const _MenuTile({required this.icon, required this.label, required this.colors, required this.textTheme, this.badgeCount=0});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(icon, size: 18),
      title: Text(label),
      trailing: badgeCount > 0 ? CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Text("$badgeCount", style: const TextStyle(fontSize: 10, color: Colors.white))) : null,
    );
  }
}

class _ContactTile extends StatelessWidget {
  final ContactEntity contact; final ColorScheme colors; final TextTheme textTheme;
  const _ContactTile({required this.contact, required this.colors, required this.textTheme});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(
        displayName: contact.name,
        avatarUrl: contact.avatarUrl,
        radius: 20,
      ),
      title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(contact.status),
    );
  }
}