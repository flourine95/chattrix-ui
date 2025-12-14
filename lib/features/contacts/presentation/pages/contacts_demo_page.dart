import 'package:flutter/material.dart';

// Giả sử file này nằm cùng thư mục hoặc import đúng đường dẫn
// import '../../../chat/presentation/pages/chat_list_demo_page.dart';

// ==========================================
// MOCK DATA: CONTACTS & REQUESTS (Giữ nguyên)
// ==========================================

enum RequestStatus { pending, sent }

class UserContactMock {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final String? bio;

  UserContactMock({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
    this.bio,
  });
}

class FriendRequestMock {
  final UserContactMock user;
  final String time;
  final RequestStatus status;
  final int mutualFriends;

  FriendRequestMock({
    required this.user,
    required this.time,
    required this.status,
    this.mutualFriends = 0,
  });
}

// Dữ liệu mẫu danh bạ
final List<UserContactMock> _allContacts = [
  UserContactMock(id: '1', name: 'An Nguyen', avatarUrl: 'https://i.pravatar.cc/150?u=101', isOnline: true),
  UserContactMock(id: '2', name: 'Anh Tuấn', avatarUrl: 'https://i.pravatar.cc/150?u=102', bio: 'Work hard play hard'),
  UserContactMock(id: '3', name: 'Bảo Bảo', avatarUrl: 'https://i.pravatar.cc/150?u=103'),
  UserContactMock(id: '4', name: 'Bình Gold', avatarUrl: 'https://i.pravatar.cc/150?u=104', isOnline: true),
  UserContactMock(id: '5', name: 'Cường Đô La', avatarUrl: 'https://i.pravatar.cc/150?u=105'),
  UserContactMock(id: '6', name: 'Dũng CT', avatarUrl: 'https://i.pravatar.cc/150?u=106', isOnline: true),
  UserContactMock(id: '7', name: 'Đạt Villa', avatarUrl: 'https://i.pravatar.cc/150?u=107'),
  UserContactMock(id: '8', name: 'Hương Giang', avatarUrl: 'https://i.pravatar.cc/150?u=108'),
  UserContactMock(id: '9', name: 'Khá Bảnh', avatarUrl: 'https://i.pravatar.cc/150?u=109'),
  UserContactMock(id: '10', name: 'Long Nón Lá', avatarUrl: 'https://i.pravatar.cc/150?u=110', bio: 'Rap việt mùa 3'),
];

// Dữ liệu mẫu lời mời
final List<FriendRequestMock> _requests = [
  FriendRequestMock(
      user: UserContactMock(id: 'r1', name: 'Sơn Tùng MTP', avatarUrl: 'https://i.pravatar.cc/150?u=201'),
      time: '2 ngày trước',
      status: RequestStatus.pending,
      mutualFriends: 15),
  FriendRequestMock(
      user: UserContactMock(id: 'r2', name: 'Jack 97', avatarUrl: 'https://i.pravatar.cc/150?u=202'),
      time: '1 tuần trước',
      status: RequestStatus.pending,
      mutualFriends: 2),
  FriendRequestMock(
      user: UserContactMock(id: 'r3', name: 'Đen Vâu', avatarUrl: 'https://i.pravatar.cc/150?u=203'),
      time: 'Vừa xong',
      status: RequestStatus.sent,
      mutualFriends: 5),
];

// Placeholder cho ChatMock để code chạy được độc lập
class ChatMock {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;
  final bool isOnline;
  final bool isGroup;

  ChatMock({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isGroup = false,
  });
}

// Dữ liệu mẫu nhóm
List<ChatMock> get _groups {
  return [
    ChatMock(
      id: '4',
      name: 'Team Project A',
      message: 'Jacob: I will handle the backend part.',
      time: 'Yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?u=4',
      unreadCount: 5,
      isOnline: true,
      isGroup: true,
    ),
    ChatMock(
      id: '8',
      name: 'Dev Team',
      message: 'Server is down! 🚨',
      time: 'Sun',
      avatarUrl: 'https://i.pravatar.cc/150?u=8',
      unreadCount: 99,
      isGroup: true,
    ),
  ];
}

// ==========================================
// CONTACT LIST PAGE (Màn hình chính)
// ==========================================
class ContactListDemoPage extends StatefulWidget {
  const ContactListDemoPage({super.key});

  @override
  State<ContactListDemoPage> createState() => _ContactListDemoPageState();
}

class _ContactListDemoPageState extends State<ContactListDemoPage> {
  // Hàm nhóm contacts theo chữ cái đầu
  Map<String, List<UserContactMock>> get _groupedContacts {
    Map<String, List<UserContactMock>> data = {};
    for (var contact in _allContacts) {
      String firstLetter = contact.name[0].toUpperCase();
      if (!data.containsKey(firstLetter)) {
        data[firstLetter] = [];
      }
      data[firstLetter]!.add(contact);
    }
    return data;
  }

  void _showAddContactSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddContactSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF3F4F6);

    final groupedData = _groupedContacts;
    final sortedKeys = groupedData.keys.toList()..sort();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        // BouncingScrollPhysics tạo cảm giác mượt mà, không dùng hiệu ứng zoom
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- HEADER ---
          SliverAppBar(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Danh bạ',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 28, // Font size lớn giống iOS style
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.person_add_rounded, color: isDark ? Colors.white : Colors.black),
                  onPressed: _showAddContactSheet,
                ),
              )
            ],
          ),

          // --- SEARCH BAR (Đã sửa cho giống Chat UI) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(30), // Bo tròn 30px giống Chat
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(Icons.search, color: Colors.grey.shade500, size: 24),
                    const SizedBox(width: 8),
                    Text('Tìm kiếm...', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // --- MENU CHỨC NĂNG ---
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.people_alt_rounded,
                  color: Colors.blueAccent,
                  title: 'Lời mời kết bạn',
                  badgeCount: _requests.where((r) => r.status == RequestStatus.pending).length,
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const FriendRequestPage())),
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.groups_rounded,
                  color: Colors.purpleAccent,
                  title: 'Nhóm chat',
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const GroupListPage())),
                  isDark: isDark,
                  surfaceColor: surfaceColor,
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: Divider(height: 32, thickness: 0.5)),

          // --- DANH SÁCH CONTACTS ---
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final letter = sortedKeys[index];
                final contacts = groupedData[letter]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header chữ cái
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        letter,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // List contacts
                    ...contacts.map((contact) => _buildContactItem(contact, isDark, surfaceColor)),
                  ],
                );
              },
              childCount: sortedKeys.length,
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }

  // Widget Item cho Menu
  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
        required Color color,
        required String title,
        int badgeCount = 0,
        required VoidCallback onTap,
        required bool isDark,
        required Color surfaceColor}) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (badgeCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            else
              Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  // Widget Contact Item đã chỉnh sửa: Thêm nút Gọi, Video, Chat
  Widget _buildContactItem(UserContactMock contact, bool isDark, Color surfaceColor) {
    return InkWell(
      onTap: () {
        // Mặc định tap vào contact sẽ mở Chat
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(radius: 26, backgroundImage: NetworkImage(contact.avatarUrl)),
                if (contact.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF31A24C),
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Tên & Bio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  if (contact.bio != null)
                    Text(
                      contact.bio!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                ],
              ),
            ),

            // --- NÚT ACTION (Call, Video, Chat) ---
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionButton(Icons.message_rounded, Colors.blueAccent, isDark, surfaceColor, () {}),
                const SizedBox(width: 8),
                _buildActionButton(Icons.call_rounded, isDark ? Colors.white : Colors.black87, isDark, surfaceColor, () {}),
                const SizedBox(width: 8),
                _buildActionButton(Icons.videocam_rounded, isDark ? Colors.white : Colors.black87, isDark, surfaceColor, () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, bool isDark, Color surfaceColor, VoidCallback onTap) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

// ==========================================
// FRIEND REQUEST PAGE (Giữ nguyên logic cũ)
// ==========================================
class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    final receivedList = _requests.where((r) => r.status == RequestStatus.pending).toList();
    final sentList = _requests.where((r) => r.status == RequestStatus.sent).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Lời mời kết bạn', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        leading: BackButton(color: isDark ? Colors.white : Colors.black),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          tabs: [
            Tab(text: 'Đã nhận (${receivedList.length})'),
            Tab(text: 'Đã gửi (${sentList.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestList(receivedList, isReceived: true, isDark: isDark),
          _buildRequestList(sentList, isReceived: false, isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildRequestList(List<FriendRequestMock> list, {required bool isReceived, required bool isDark}) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline_rounded, size: 60, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text('Không có lời mời nào', style: TextStyle(color: Colors.grey.shade500)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final req = list[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 36, backgroundImage: NetworkImage(req.user.avatarUrl)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(req.user.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                      Text(req.time, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (req.mutualFriends > 0)
                    Text('${req.mutualFriends} bạn chung', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(isReceived ? 'Chấp nhận' : 'Hủy lời mời', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      if (isReceived) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                              foregroundColor: isDark ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 0,
                            ),
                            child: const Text('Xóa', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ]
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

// ==========================================
// GROUP LIST PAGE (Giữ nguyên)
// ==========================================
class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text('Nhóm của bạn', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
        leading: BackButton(color: isDark ? Colors.white : Colors.black),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Tạo mới', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: _groups.isEmpty
          ? Center(child: Text("Chưa tham gia nhóm nào", style: TextStyle(color: Colors.grey.shade500)))
          : ListView.builder(
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Stack(
              children: [
                CircleAvatar(radius: 28, backgroundImage: NetworkImage(group.avatarUrl)),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                    child: const Icon(Icons.group_rounded, size: 14, color: Colors.blueAccent),
                  ),
                )
              ],
            ),
            title: Text(group.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
            subtitle: Text("Hoạt động gần đây: ${group.time}", style: TextStyle(color: Colors.grey.shade500)),
          );
        },
      ),
    );
  }
}

// ==========================================
// ADD CONTACT SHEET (Giữ nguyên)
// ==========================================
class AddContactSheet extends StatelessWidget {
  const AddContactSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy', style: TextStyle(fontSize: 16))),
                Text('Thêm liên hệ mới', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor)),
                TextButton(onPressed: () {}, child: const Text('Thêm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt_rounded, size: 30, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),
                _buildTextField('Họ', isDark),
                const SizedBox(height: 12),
                _buildTextField('Tên', isDark),
                const SizedBox(height: 12),
                _buildTextField('Số điện thoại', isDark, keyboardType: TextInputType.phone),
              ],
            ),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.blueAccent),
            ),
            title: Text('Quét mã QR', style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade400),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, bool isDark, {TextInputType? keyboardType}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}