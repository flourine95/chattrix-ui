import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ==========================================
// MOCK DATA
// ==========================================
class ChatMock {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;
  final bool isRead;
  final bool isSent;
  final String? note;
  final bool isGroup;

  ChatMock({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
    this.isRead = false,
    this.isSent = false,
    this.note,
    this.isGroup = false,
  });
}

final List<ChatMock> _allChats = [
  ChatMock(
    id: '1',
    name: 'Alberne',
    message: 'Tối nay đi ăn không?',
    time: '2m',
    avatarUrl: 'https://i.pravatar.cc/150?u=1',
    unreadCount: 3,
    isOnline: true,
    note: 'Đói quá 🍜',
  ),
  ChatMock(
    id: '2',
    name: 'Hồng Nhung',
    message: 'Đang soạn tin...',
    time: 'Now',
    avatarUrl: 'https://i.pravatar.cc/150?u=2',
    isTyping: true,
    isOnline: true,
    note: 'Nhạc hay 🎶',
  ),
  ChatMock(
    id: '3',
    name: 'Dev Team 🚀',
    message: 'Long: Đã merge code nha anh em.',
    time: '1h',
    avatarUrl: 'https://i.pravatar.cc/150?u=8',
    unreadCount: 12,
    isGroup: true,
  ),
  ChatMock(
    id: '4',
    name: 'Tuấn Anh',
    message: 'Ok chốt đơn.',
    time: '3h',
    avatarUrl: 'https://i.pravatar.cc/150?u=3',
    isRead: true,
    isSent: true,
    isOnline: false,
    note: 'Gym time 💪',
  ),
  ChatMock(
    id: '5',
    name: 'Design Team',
    message: 'Gửi file figma mới.',
    time: 'Yesterday',
    avatarUrl: 'https://i.pravatar.cc/150?u=4',
    isSent: true,
    isRead: false,
    isGroup: true,
  ),
  ChatMock(
    id: '6',
    name: 'Gia đình 🏠',
    message: 'Mẹ: Về ăn cơm nha con.',
    time: 'Yesterday',
    avatarUrl: 'https://i.pravatar.cc/150?u=10',
    isGroup: true,
    unreadCount: 1,
  ),
  ChatMock(
    id: '7',
    name: 'Minh Khôi',
    message: 'Đã nhận tiền.',
    time: 'Mon',
    avatarUrl: 'https://i.pravatar.cc/150?u=6',
    isRead: true,
    isSent: true,
    note: 'Deadline dí 🥲',
  ),
  ChatMock(
    id: '8',
    name: 'Support',
    message: 'Yêu cầu đang xử lý.',
    time: 'Sun',
    avatarUrl: 'https://i.pravatar.cc/150?u=7',
  ),
  ChatMock(
    id: '9',
    name: 'John Doe',
    message: 'Hello!',
    time: 'Sun',
    avatarUrl: 'https://i.pravatar.cc/150?u=9',
    isOnline: true,
  ),
  ChatMock(
    id: '10',
    name: 'Sarah',
    message: 'Call me maybe?',
    time: 'Sun',
    avatarUrl: 'https://i.pravatar.cc/150?u=12',
    isOnline: true,
    note: 'Chilling ☕️',
  ),
];

// ==========================================
// MOCK DATA CHO TIN NHẮN (MESSAGE)
// ==========================================
class MessageMock {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final String? senderName; // Chỉ dùng cho Group
  final String? senderAvatar; // Chỉ dùng cho Group
  final bool isImage; // Giả lập tin nhắn ảnh

  MessageMock({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.senderName,
    this.senderAvatar,
    this.isImage = false,
  });
}

// Dữ liệu giả lập
// ==========================================
// MOCK DATA: DANH SÁCH TIN NHẮN DÀI
// ==========================================
final List<MessageMock> _mockMessages = [
  // --- HÔM NAY (Mới nhất nằm đầu mảng vì list reverse) ---
  MessageMock(id: 'm1', text: 'Oke chốt vậy nhé, mai gặp lại anh em! 👋', isMe: true, time: '22:30'),
  MessageMock(
    id: 'm2',
    text: 'Nhất trí, ngủ ngon nha mọi người.',
    isMe: false,
    time: '22:29',
    senderName: 'Tuấn Anh',
    senderAvatar: 'https://i.pravatar.cc/150?u=3',
  ),
  MessageMock(
    id: 'm3',
    text: 'G9 all! 😴',
    isMe: false,
    time: '22:28',
    senderName: 'Hồng Nhung',
    senderAvatar: 'https://i.pravatar.cc/150?u=2',
  ),
  MessageMock(id: 'm4', text: 'Mai nhớ mang theo sạc laptop nha ông, tui quên ở cty rồi.', isMe: true, time: '22:25'),
  MessageMock(
    id: 'm5',
    text: 'Ok ông, để tui note lại không quên.',
    isMe: false,
    time: '22:24',
    senderName: 'Minh Khôi',
    senderAvatar: 'https://i.pravatar.cc/150?u=6',
  ),
  MessageMock(id: 'm6', text: 'À nãy tui có gửi mail confirm với bên khách hàng rồi đó.', isMe: true, time: '21:15'),
  MessageMock(
    id: 'm7',
    text: 'Tuyệt vời, thanks Long nhé!',
    isMe: false,
    time: '21:14',
    senderName: 'Alberne',
    senderAvatar: 'https://i.pravatar.cc/150?u=1',
  ),
  MessageMock(
    id: 'm8',
    text: 'Mọi người check thử cái UI này xem ổn không?',
    isMe: false,
    time: '20:00',
    senderName: 'Design Team',
    senderAvatar: 'https://i.pravatar.cc/150?u=4',
  ),
  MessageMock(
    id: 'm9',
    text: 'https://picsum.photos/400/300',
    // Giả lập ảnh 1
    isMe: false,
    isImage: true,
    time: '20:00',
    senderName: 'Design Team',
    senderAvatar: 'https://i.pravatar.cc/150?u=4',
  ),
  MessageMock(
    id: 'm10',
    text: 'Đẹp đó, nhưng màu nút bấm hơi chìm, cho nó nổi hơn chút được không?',
    isMe: true,
    time: '20:05',
  ),
  MessageMock(
    id: 'm11',
    text: 'Đồng ý với Long, chuyển sang màu gradient xanh tím thử xem.',
    isMe: false,
    time: '20:07',
    senderName: 'Sarah',
    senderAvatar: 'https://i.pravatar.cc/150?u=12',
  ),
  MessageMock(
    id: 'm12',
    text: 'Ok để team sửa lại rồi gửi bản v2 nhé.',
    isMe: false,
    time: '20:10',
    senderName: 'Design Team',
    senderAvatar: 'https://i.pravatar.cc/150?u=4',
  ),

  // --- TIN NHẮN DÀI (TEST XUỐNG DÒNG) ---
  MessageMock(
    id: 'm13',
    text:
        'Anh em lưu ý ngày mai họp lúc 9h sáng nhé. Nội dung cuộc họp bao gồm:\n1. Review tiến độ dự án\n2. Phân chia task tuần mới\n3. Thảo luận về vấn đề performance của App.\nMọi người chuẩn bị báo cáo đầy đủ nha.',
    isMe: false,
    time: '19:30',
    senderName: 'Project Manager',
    senderAvatar: 'https://i.pravatar.cc/150?u=8',
  ),
  MessageMock(
    id: 'm14',
    text: 'Đã nhận thông tin. Em sẽ chuẩn bị slide báo cáo phần Backend.',
    isMe: true,
    time: '19:35',
  ),
  MessageMock(
    id: 'm15',
    text: 'Em xin phép mai vào trễ 15p do đưa con đi học ạ.',
    isMe: false,
    time: '19:40',
    senderName: 'Hồng Nhung',
    senderAvatar: 'https://i.pravatar.cc/150?u=2',
  ),

  // --- HÔM QUA ---
  MessageMock(id: 'm16', text: 'Tối qua đi ăn lẩu ngon vãi.', isMe: true, time: 'Yesterday'),
  MessageMock(
    id: 'm17',
    text: 'https://picsum.photos/400/400',
    // Giả lập ảnh 2
    isMe: true,
    isImage: true,
    time: 'Yesterday',
  ),
  MessageMock(
    id: 'm18',
    text: 'Nhìn thèm thế 🤤',
    isMe: false,
    time: 'Yesterday',
    senderName: 'Tuấn Anh',
    senderAvatar: 'https://i.pravatar.cc/150?u=3',
  ),
  MessageMock(
    id: 'm19',
    text: 'Bữa nào rủ cả team đi đi.',
    isMe: false,
    time: 'Yesterday',
    senderName: 'Tuấn Anh',
    senderAvatar: 'https://i.pravatar.cc/150?u=3',
  ),
  MessageMock(id: 'm20', text: 'Đợi lãnh lương đã ông ơi =))', isMe: true, time: 'Yesterday'),

  // --- NGÀY CŨ HƠN ---
  MessageMock(
    id: 'm21',
    text: 'Fix xong cái bug login chưa Long?',
    isMe: false,
    time: 'Mon',
    senderName: 'Alberne',
    senderAvatar: 'https://i.pravatar.cc/150?u=1',
  ),
  MessageMock(id: 'm22', text: 'Xong rồi nha, đang chờ tester verify lại.', isMe: true, time: 'Mon'),
  MessageMock(
    id: 'm23',
    text: 'Oke good job.',
    isMe: false,
    time: 'Mon',
    senderName: 'Alberne',
    senderAvatar: 'https://i.pravatar.cc/150?u=1',
  ),
  MessageMock(id: 'm24', text: 'Hello World!', isMe: true, time: 'Sun'),
  MessageMock(
    id: 'm25',
    text: 'Chào mừng Long gia nhập team! 🎉',
    isMe: false,
    time: 'Sun',
    senderName: 'Dev Team',
    senderAvatar: 'https://i.pravatar.cc/150?u=8',
  ),
  MessageMock(id: 'm26', text: 'Rất vui được làm việc cùng mọi người ạ.', isMe: true, time: 'Sun'),
];

enum ChatFilter { all, unread, groups }

class ChatListPagePreview extends StatefulWidget {
  const ChatListPagePreview({super.key});

  @override
  State<ChatListPagePreview> createState() => _ChatListPagePreviewState();
}

class _ChatListPagePreviewState extends State<ChatListPagePreview> {
  ChatFilter _selectedFilter = ChatFilter.all;

  List<ChatMock> get _filteredChats {
    switch (_selectedFilter) {
      case ChatFilter.unread:
        return _allChats.where((chat) => chat.unreadCount > 0).toList();
      case ChatFilter.groups:
        return _allChats.where((chat) => chat.isGroup).toList();
      case ChatFilter.all:
        return _allChats;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF3F4F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverAppBar(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent,
            floating: true,
            pinned: true,
            centerTitle: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: const Text('Chats', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                // --- SỬA ĐOẠN NÀY ĐỂ ICON TRÒN MỊN ---
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Material(
                    color: surfaceColor,
                    shape: const CircleBorder(), // Định hình tròn vector
                    clipBehavior: Clip.antiAlias, // Khử răng cưa
                    child: InkWell(
                      onTap: () {},
                      // Không cần borderRadius vì Material đã lo
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/message-circle-plus.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(isDark ? Colors.white : Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
                // -------------------------------------
              ),
            ],
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 46,
                decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(Icons.search, color: Colors.grey.shade500, size: 24),
                    const SizedBox(width: 8),
                    Text('Search', style: TextStyle(color: Colors.grey.shade500, fontSize: 17)),
                  ],
                ),
              ),
            ),
          ),

          // Filters
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildFilterChip('Tất cả', ChatFilter.all, isDark, surfaceColor),
                  const SizedBox(width: 10),
                  _buildFilterChip('Chưa đọc', ChatFilter.unread, isDark, surfaceColor),
                  const SizedBox(width: 10),
                  _buildFilterChip('Nhóm', ChatFilter.groups, isDark, surfaceColor),
                ],
              ),
            ),
          ),

          // Online List (Only visible in 'All')
          if (_selectedFilter == ChatFilter.all)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    if (index == 0) return _buildMyStoryItem(isDark, surfaceColor);
                    final userIndex = (index - 1) % _allChats.length;
                    return _buildOnlineUserItem(_allChats[userIndex], isDark, surfaceColor);
                  },
                ),
              ),
            ),

          // Chat List
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final chats = _filteredChats;
              if (index >= chats.length) return null;
              return _ChatItem(chat: chats[index]);
            }, childCount: _filteredChats.length),
          ),

          if (_filteredChats.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Text('Không tìm thấy tin nhắn nào', style: TextStyle(color: Colors.grey.shade500)),
                ),
              ),
            ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }

  // --- Sub Widgets ---
  Widget _buildFilterChip(String label, ChatFilter filter, bool isDark, Color surfaceColor) {
    final isSelected = _selectedFilter == filter;
    final bgColor = isSelected ? (isDark ? Colors.white : Colors.black) : surfaceColor;
    final textColor = isSelected ? (isDark ? Colors.black : Colors.white) : (isDark ? Colors.white70 : Colors.black87);
    return InkWell(
      onTap: () => setState(() => _selectedFilter = filter),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildMyStoryItem(bool isDark, Color surfaceColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=0')),
                Positioned(
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Text("Ghi chú...", style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(2.5),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('Tin của bạn', style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildOnlineUserItem(ChatMock user, bool isDark, Color surfaceColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(radius: 30, backgroundImage: NetworkImage(user.avatarUrl)),
                if (user.note != null)
                  Positioned(
                    top: -12,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 80),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? Colors.transparent : Colors.grey.shade200, width: 1),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Text(
                        user.note!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                if (user.isOnline)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF31A24C),
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 64,
            child: Text(
              user.name.split(' ').first,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH CHAT CHI TIẾT (DÙNG CHUNG 1-1 & GROUP)
// ==========================================
// ==========================================
// MÀN HÌNH CHAT CHI TIẾT (ĐÃ THAY ICON HIỆN ĐẠI)
// ==========================================
class ChatDetailPage extends StatefulWidget {
  final ChatMock chat;

  const ChatDetailPage({super.key, required this.chat});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF3F4F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context, isDark, surfaceColor),
      body: SafeArea(
        child: Column(
          children: [
            // --- DANH SÁCH TIN NHẮN ---
            Expanded(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  itemCount: _mockMessages.length,
                  itemBuilder: (context, index) {
                    final message = _mockMessages[index];
                    bool isLastMessage = index == 0;
                    return _buildMessageBubble(message, isDark, surfaceColor, isLastMessage);
                  },
                ),
              ),
            ),

            // --- THANH INPUT BAR (Icons mới) ---
            _buildInputBar(isDark, surfaceColor),
          ],
        ),
      ),
    );
  }

  // --- APP BAR (Icons Rounded/Outlined) ---
  AppBar _buildAppBar(BuildContext context, bool isDark, Color surfaceColor) {
    // Màu icon trên AppBar (Blue hoặc theo Theme)
    const appBarIconColor = Colors.blueAccent;

    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          // Icon Back bo tròn
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: appBarIconColor, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 18, backgroundImage: NetworkImage(widget.chat.avatarUrl)),
              if (widget.chat.isOnline)
                Positioned(
                  right: 0, bottom: 0,
                  child: Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF31A24C),
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? Colors.black : Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.chat.isGroup
                      ? '12 thành viên'
                      : (widget.chat.isOnline ? 'Đang hoạt động' : 'Hoạt động 15p trước'),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Thay icon đặc bằng icon rounded/outlined nhìn thoáng hơn
        IconButton(icon: const Icon(Icons.call_outlined, color: appBarIconColor), onPressed: () {}),
        IconButton(icon: const Icon(Icons.videocam_outlined, color: appBarIconColor), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.info_outline_rounded, color: appBarIconColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatInfoPageDemo(chat: widget.chat),
              ),
            );
          },
        ),
        const SizedBox(width: 6),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: isDark ? Colors.grey.shade900 : Colors.grey.shade200, height: 1),
      ),
    );
  }

  // --- MESSAGE BUBBLE (Giữ nguyên logic cũ) ---
  Widget _buildMessageBubble(MessageMock message, bool isDark, Color surfaceColor, bool isLastMessage) {
    final showAvatar = !message.isMe;
    final showName = !message.isMe && widget.chat.isGroup;
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleMaxWidth = screenWidth * 0.67;

    return Padding(
      padding: EdgeInsets.only(bottom: isLastMessage ? 5 : 12),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showAvatar)
            CircleAvatar(radius: 14, backgroundImage: NetworkImage(message.senderAvatar ?? widget.chat.avatarUrl))
          else if (!message.isMe)
            const SizedBox(width: 28),

          const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (showName && message.senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 4),
                    child: Text(message.senderName!, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ),
                Container(
                  constraints: BoxConstraints(maxWidth: bubbleMaxWidth),
                  padding: message.isImage
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: message.isMe
                        ? Colors.blueAccent
                        : (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(message.isMe ? 18 : 4),
                      bottomRight: Radius.circular(message.isMe ? 4 : 18),
                    ),
                    image: message.isImage
                        ? DecorationImage(image: NetworkImage(message.text), fit: BoxFit.cover)
                        : null,
                  ),
                  child: message.isImage
                      ? const SizedBox(width: 220, height: 160)
                      : Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 16, height: 1.3,
                      color: message.isMe ? Colors.white : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- INPUT BAR (ICON HIỆN ĐẠI HƠN) ---
  Widget _buildInputBar(bool isDark, Color surfaceColor) {
    final iconColor = Colors.blueAccent;
    final inputFieldColor = isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF0F2F5);

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // CỤM ICON CHỨC NĂNG TRÁI
              Row(
                children: [
                  // Dùng add_circle_rounded hoặc add_circle (solid) đều được, nhưng size vừa phải
                  _buildActionIcon(Icons.add_circle, iconColor, size: 28),

                  // Thay camera_alt (nhọn) bằng camera_alt_rounded (tròn)
                  _buildActionIcon(Icons.camera_alt_rounded, iconColor, size: 26),

                  // Thay image (vuông) bằng photo_outlined (thoáng hơn)
                  _buildActionIcon(Icons.photo_outlined, iconColor, size: 26),

                  // Thay mic (đặc) bằng mic_none_rounded (rỗng)
                  _buildActionIcon(Icons.mic_none_rounded, iconColor, size: 26),
                ],
              ),

              const SizedBox(width: 4),

              // Ô NHẬP LIỆU
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 44, maxHeight: 120),
                  decoration: BoxDecoration(
                    color: inputFieldColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16, height: 1.3,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Nhắn tin...',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                            isDense: true,
                          ),
                        ),
                      ),

                      // Icon mặt cười
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 12),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          // Dùng icon mặt cười bo tròn
                          child: Icon(Icons.sentiment_satisfied_alt_rounded, color: iconColor, size: 26),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // NÚT LIKE / SEND
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: _isTyping
                      ? InkWell(
                    key: const ValueKey('send'),
                    onTap: () {
                      _controller.clear();
                      setState(() => _isTyping = false);
                    },
                    // Icon Send bo tròn
                    child: Icon(Icons.send_rounded, color: iconColor, size: 28),
                  )
                      : InkWell(
                    key: const ValueKey('like'),
                    onTap: () {},
                    // Icon Like bo tròn
                    child: Icon(Icons.thumb_up_alt_rounded, color: iconColor, size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper cho Icon
  Widget _buildActionIcon(IconData icon, Color color, {double size = 26}) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 10),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
// ==========================================
// CẬP NHẬT CHÍNH: CHAT ITEM VỚI SỐ LƯỢNG TIN NHẮN
// ==========================================
class _ChatItem extends StatelessWidget {
  final ChatMock chat;

  const _ChatItem({required this.chat});

  // Hàm hiển thị Menu khi nhấn giữ
  void _showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final color = isDark ? const Color(0xFF1C1C1E) : Colors.white;

        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.mark_chat_read),
                  title: const Text('Đánh dấu đã đọc'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_off),
                  title: const Text('Tắt thông báo'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.archive),
                  title: const Text('Lưu trữ'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Xóa đoạn chat', style: TextStyle(color: Colors.red)),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUnread = chat.unreadCount > 0;

    final nameStyle = TextStyle(
      fontSize: 17,
      fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
      color: isDark ? Colors.white : Colors.black,
    );
    final messageStyle = TextStyle(
      fontSize: 15,
      color: isUnread
          ? (isDark ? Colors.white : Colors.black87)
          : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
      fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
    );

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailPage(chat: chat)));
      },
      onLongPress: () => _showChatOptions(context),
      overlayColor: WidgetStateProperty.all(Colors.grey.withValues(alpha: 0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(radius: 30, backgroundImage: NetworkImage(chat.avatarUrl)),
                if (chat.isGroup)
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.people, size: 12, color: Colors.black54),
                      ),
                    ),
                  )
                else if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF31A24C),
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? Colors.black : Colors.white, width: 3),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(chat.name, style: nameStyle),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: chat.isTyping
                            ? const Text(
                                'Đang soạn tin...',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : Row(
                                children: [
                                  if (chat.isSent)
                                    Text('Bạn: ', style: messageStyle.copyWith(fontWeight: FontWeight.normal)),
                                  Expanded(
                                    child: Text(
                                      chat.message,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: messageStyle,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text('·', style: messageStyle),
                      ),
                      Text(chat.time, style: messageStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),

            // --- STATUS COLUMN (Badge / Seen) ---
            const SizedBox(width: 8),
            if (chat.unreadCount > 0)
              // HIỂN THỊ SỐ LƯỢNG TIN NHẮN (BADGE)
              Container(
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                // Đảm bảo kích thước tối thiểu
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                // Padding cho số lớn
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444), // Màu đỏ thông báo
                  borderRadius: BorderRadius.circular(10), // Bo tròn thành Pill shape
                ),
                child: Center(
                  child: Text(
                    chat.unreadCount > 9 ? '9+' : chat.unreadCount.toString(),
                    // Logic hiện 9+
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else if (chat.isSent)
              if (chat.isRead)
                CircleAvatar(radius: 8, backgroundImage: NetworkImage(chat.avatarUrl))
              else
                Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// TRANG THÔNG TIN CHI TIẾT (INFO PAGE)
// ==========================================
class ChatInfoPageDemo extends StatelessWidget {
  final ChatMock chat;

  const ChatInfoPageDemo({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : const Color(0xFFF5F5F5); // Nền xám nhạt cho light mode
    final surfaceColor = isDark ? const Color(0xFF1C1C1E) : Colors.white; // Màu các khối
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // --- 1. PROFILE HEADER ---
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Avatar lớn
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(chat.avatarUrl),
                      ),
                      if (chat.isOnline)
                        Positioned(
                          right: 4,
                          bottom: 4,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF31A24C),
                              shape: BoxShape.circle,
                              border: Border.all(color: backgroundColor, width: 3.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tên
                  Text(
                    chat.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Trạng thái (Active status)
                  if (!chat.isGroup)
                    Text(
                      chat.isOnline ? 'Đang hoạt động' : 'Hoạt động 15 phút trước',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. ACTION BUTTONS ROW ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(context, Icons.call, 'Gọi thoại', isDark),
                _buildActionButton(context, Icons.videocam, 'Video', isDark),
                _buildActionButton(context, Icons.person, 'Trang cá nhân', isDark),
                _buildActionButton(context, Icons.notifications_off, 'Tắt báo', isDark),
              ],
            ),

            const SizedBox(height: 24),

            // --- 3. CUSTOMIZATION SECTION ---
            _buildSection(
              title: 'Tùy chỉnh',
              children: [
                _buildListTile(
                  icon: Icons.palette_rounded,
                  iconColor: Colors.purpleAccent,
                  title: 'Chủ đề',
                  subtitle: 'Mặc định',
                  isDark: isDark,
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.emoji_emotions_rounded,
                  iconColor: Colors.blueAccent,
                  title: 'Biểu tượng cảm xúc',
                  subtitle: '👍',
                  isDark: isDark,
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.text_fields_rounded,
                  iconColor: Colors.green,
                  title: 'Biệt danh',
                  isDark: isDark,
                  onTap: () {},
                ),
              ],
              isDark: isDark,
              surfaceColor: surfaceColor,
            ),

            const SizedBox(height: 20),

            // --- 4. MEDIA & FILES ---
            _buildSection(
              title: 'File & Đa phương tiện',
              children: [
                _buildListTile(
                  icon: Icons.image_rounded,
                  iconColor: Colors.pinkAccent,
                  title: 'Xem ảnh & video',
                  isDark: isDark,
                  onTap: () {},
                ),
                // Preview ảnh (Horizontal Scroll)
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 16, bottom: 16, top: 4),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    separatorBuilder: (ctx, i) => const SizedBox(width: 8),
                    itemBuilder: (ctx, i) {
                      return Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage('https://picsum.photos/200/200?random=$i'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildListTile(
                  icon: Icons.folder_rounded,
                  iconColor: Colors.orangeAccent,
                  title: 'Xem file',
                  isDark: isDark,
                  onTap: () {},
                ),
              ],
              isDark: isDark,
              surfaceColor: surfaceColor,
            ),

            const SizedBox(height: 20),

            // --- 5. PRIVACY & SUPPORT ---
            _buildSection(
              title: 'Quyền riêng tư',
              children: [
                _buildListTile(
                  icon: Icons.notifications_none_rounded,
                  iconColor: isDark ? Colors.white : Colors.black54,
                  title: 'Tắt thông báo',
                  isDark: isDark,
                  hasSwitch: true,
                ),
                _buildListTile(
                  icon: Icons.search_rounded,
                  iconColor: isDark ? Colors.white : Colors.black54,
                  title: 'Tìm kiếm trong cuộc trò chuyện',
                  isDark: isDark,
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.block_rounded,
                  iconColor: Colors.redAccent,
                  title: 'Chặn',
                  textColor: Colors.redAccent,
                  isDark: isDark,
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.report_gmailerrorred_rounded,
                  iconColor: Colors.redAccent,
                  title: 'Báo cáo',
                  textColor: Colors.redAccent,
                  isDark: isDark,
                  hideArrow: true, // Không hiện mũi tên cho mục báo cáo
                  onTap: () {},
                ),
              ],
              isDark: isDark,
              surfaceColor: surfaceColor,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: BUTTON TRÒN ---
  Widget _buildActionButton(BuildContext context, IconData icon, String label, bool isDark) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(24),
            child: Icon(icon, color: isDark ? Colors.white : Colors.black87, size: 22),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  // --- WIDGET HELPER: GROUP SECTION (KHỐI CONG) ---
  Widget _buildSection({
    required String title,
    required List<Widget> children,
    required bool isDark,
    required Color surfaceColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: surfaceColor,
            // Nếu muốn bo góc giống iOS Grouped List thì bật dòng dưới
            // borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  // --- WIDGET HELPER: MỤC DANH SÁCH (LIST TILE) ---
  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool isDark,
    bool hasSwitch = false,
    Color? textColor,
    bool hideArrow = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: hasSwitch ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon bên trái
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                ],
              ),
            ),

            // Phần bên phải (Mũi tên hoặc Switch)
            if (hasSwitch)
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: false, // Demo state
                  onChanged: (val) {},
                  activeTrackColor: Colors.green,
                  activeThumbColor: Colors.white,
                ),
              )
            else if (!hideArrow)
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

