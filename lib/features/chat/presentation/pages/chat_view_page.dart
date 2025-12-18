import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/data/models/chat_message_request.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/message_bubble.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/reply_message_preview.dart';
import 'package:chattrix_ui/features/chat/services/cloudinary_provider.dart';
import 'package:chattrix_ui/features/chat/services/media_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId});

  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- Controller & State ---
    final controller = useTextEditingController();
    useListenable(controller);
    final scrollController = useScrollController();
    final focusNode = useFocusNode();
    final appLifecycleState = useAppLifecycleState();

    final showScrollButton = useState(false);

    // Gallery State
    final showGallery = useState(false);
    final albums = useState<List<AssetPathEntity>>([]);
    final currentAlbum = useState<AssetPathEntity?>(null);
    final assets = useState<List<AssetEntity>>([]);
    final selectedAssets = useState<List<AssetEntity>>([]);

    // Chat Logic State
    final replyToMessage = useState<Message?>(null);
    final isRecording = useState(false);

    // --- DATA ---
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;
    final backgroundColor = theme.scaffoldBackgroundColor;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));
    final wsConnection = ref.watch(webSocketConnectionProvider);
    final wsDataSource = ref.watch(chatWebSocketDataSourceProvider);
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.value?.lookup(chatId);

    // --- LOGIC LOAD ẢNH ---
    Future<void> loadImages() async {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth) {
        await PhotoManager.clearFileCache();
        final filter = FilterOptionGroup(orders: [OrderOption(type: OrderOptionType.createDate, asc: false)]);
        final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
          type: RequestType.common,
          filterOption: filter,
        );

        albums.value = paths;
        if (paths.isNotEmpty) {
          final target = currentAlbum.value ?? paths.first;
          final validAlbum = paths.firstWhere((a) => a.id == target.id, orElse: () => paths.first);
          currentAlbum.value = validAlbum;
          assets.value = await validAlbum.getAssetListPaged(page: 0, size: 80);
        }
      }
    }

    useEffect(() {
      loadImages();
      return null;
    }, []);

    useEffect(() {
      if (appLifecycleState == AppLifecycleState.resumed) loadImages();
      return null;
    }, [appLifecycleState]);

    Future<void> changeAlbum(AssetPathEntity album) async {
      currentAlbum.value = album;
      assets.value = await album.getAssetListPaged(page: 0, size: 80);
    }

    // --- SCROLL LOGIC ---
    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }

    useEffect(() {
      void scrollListener() {
        if (!scrollController.hasClients) return;
        if (scrollController.offset > 500) {
          if (!showScrollButton.value) showScrollButton.value = true;
        } else {
          if (showScrollButton.value) showScrollButton.value = false;
        }
      }

      scrollController.addListener(scrollListener);
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    // --- HANDLERS ---
    void toggleGallery() {
      if (showGallery.value) {
        showGallery.value = false;
        focusNode.requestFocus();
      } else {
        focusNode.unfocus();
        Future.delayed(const Duration(milliseconds: 100), () {
          showGallery.value = true;
          loadImages();
        });
      }
    }

    Future<void> sendMessage({String? specificContent, String type = 'TEXT', String? mediaUrl, int? duration}) async {
      if (selectedAssets.value.isNotEmpty && mediaUrl == null) {
        final cloudinary = ref.read(cloudinaryServiceProvider);
        for (var asset in selectedAssets.value) {
          File? file = await asset.file;
          if (file != null) {
            try {
              final response = asset.type == AssetType.video
                  ? await cloudinary.uploadAudio(file)
                  : await cloudinary.uploadImage(file);

              sendMessage(
                specificContent: '',
                type: asset.type == AssetType.video ? 'VIDEO' : 'IMAGE',
                mediaUrl: response.url,
                duration: asset.duration,
              );
            } catch (_) {}
          }
        }
        selectedAssets.value = [];
        return;
      }

      final content = specificContent ?? controller.text.trim();
      if (content.isEmpty && mediaUrl == null) return;

      final replyId = replyToMessage.value?.id;
      if (specificContent == null) controller.clear();
      replyToMessage.value = null;
      showGallery.value = false;
      scrollToBottom();

      final request = ChatMessageRequest(
        content: content,
        type: type,
        replyToMessageId: replyId,
        mediaUrl: mediaUrl,
        duration: duration,
      );

      if (wsConnection.isConnected) {
        wsDataSource.sendMessage(chatId, request);
      } else {
        final usecase = ref.read(sendMessageUsecaseProvider);
        await usecase(conversationId: chatId, request: request);
        ref.read(messagesProvider(chatId).notifier).refresh();
      }
    }

    Future<void> handleCamera() async {
      final mediaPicker = ref.read(mediaPickerServiceProvider);
      final file = await mediaPicker.takePhoto(context);
      loadImages();
      if (file != null) {
        final cloudinary = ref.read(cloudinaryServiceProvider);
        try {
          final response = await cloudinary.uploadImage(file);
          sendMessage(specificContent: '', type: 'IMAGE', mediaUrl: response.url);
        } catch (_) {}
      }
    }

    // --- UI ---
    return PopScope(
      canPop: !showGallery.value,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        showGallery.value = false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        // HEADER
        appBar: _buildFullAppBar(context, conversation, me, isDark),
        body: GestureDetector(
          onTap: () {
            if (showGallery.value) showGallery.value = false;
            focusNode.unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _MessageList(
                      messagesAsync: messagesAsync,
                      me: me,
                      scrollController: scrollController,
                      onReply: (m) => replyToMessage.value = m,
                      onReactionTap: (m, e) =>
                          ref.read(toggleReactionUsecaseProvider)(messageId: m.id.toString(), emoji: e),
                      onAddReaction: (m) => showReactionPicker(
                        context,
                        (e) => ref.read(toggleReactionUsecaseProvider)(messageId: m.id.toString(), emoji: e),
                      ),
                      onEdit: (m) async {},
                      onDelete: (m) async {
                        await ref.read(deleteMessageUsecaseProvider)(messageId: m.id.toString());
                        ref.read(messagesProvider(chatId).notifier).refresh();
                      },
                    ),

                    if (showScrollButton.value)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: FloatingActionButton.small(
                            onPressed: scrollToBottom,
                            backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                            foregroundColor: primaryColor,
                            shape: const CircleBorder(),
                            child: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (replyToMessage.value != null)
                    ReplyMessagePreview(
                      replyToMessage: replyToMessage.value!,
                      onCancel: () => replyToMessage.value = null,
                    ),

                  _InputBar(
                    controller: controller,
                    focusNode: focusNode,
                    onSend: sendMessage,
                    chatId: chatId,
                    isDark: isDark,
                    primaryColor: primaryColor,
                    showGallery: showGallery.value,
                    canSendMessage: controller.text.trim().isNotEmpty || selectedAssets.value.isNotEmpty,
                    onToggleGallery: toggleGallery,
                    isRecording: isRecording,
                  ),
                ],
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutQuad,
                height: showGallery.value ? MediaQuery.of(context).size.height * 0.45 : 0,
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                child: showGallery.value
                    ? _RealMediaGallery(
                        albums: albums.value,
                        currentAlbum: currentAlbum.value,
                        assets: assets.value,
                        selectedAssets: selectedAssets.value,
                        onCameraTap: handleCamera,
                        onAlbumChanged: changeAlbum,
                        onAssetSelect: (asset) {
                          final list = List<AssetEntity>.from(selectedAssets.value);
                          list.contains(asset) ? list.remove(asset) : list.add(asset);
                          selectedAssets.value = list;
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildFullAppBar(BuildContext context, dynamic conversation, dynamic me, bool isDark) {
    final color = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    if (conversation == null) {
      return AppBar(elevation: 0, backgroundColor: appBarColor, surfaceTintColor: Colors.transparent);
    }

    final title = ConversationUtils.getConversationTitle(conversation, me);

    // Check if it's a group conversation
    final bool isGroup = conversation.type == ConversationType.group;

    // Get avatar URL based on conversation type
    String? avatarUrl;
    if (isGroup) {
      // For group conversations, use the group avatar
      avatarUrl = conversation.avatarUrl;
    } else {
      // For direct conversations, get the other participant's avatar
      avatarUrl = ConversationUtils.getOtherParticipantAvatarUrl(conversation, me);
    }

    // Check online status only for direct conversations
    final bool isOnline = isGroup ? false : ConversationUtils.isUserOnline(conversation, me);

    return AppBar(
      backgroundColor: appBarColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      scrolledUnderElevation: 2,
      leadingWidth: 40,
      leading: BackButton(color: color, onPressed: () => context.pop()),
      title: Row(
        children: [
          UserAvatar(avatarUrl: avatarUrl, displayName: title, radius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (!isGroup) ...[
                  const SizedBox(height: 2),
                  Text(
                    isOnline ? "Đang hoạt động" : "Offline",
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Audio call button
        IconButton(
          icon: Icon(Icons.call_outlined, color: color, size: 24),
          onPressed: () {
            // TODO: Implement audio call
            debugPrint('Audio call pressed');
          },
          tooltip: 'Audio call',
        ),
        // Video call button
        IconButton(
          icon: Icon(Icons.videocam_outlined, color: color, size: 26),
          onPressed: () {
            // TODO: Implement video call
            debugPrint('Video call pressed');
          },
          tooltip: 'Video call',
        ),
        // Info button
        IconButton(
          icon: Icon(Icons.info_outline, color: color, size: 24),
          onPressed: () {
            // TODO: Navigate to conversation info
            debugPrint('Info pressed');
          },
          tooltip: 'Thông tin',
        ),
      ],
    );
  }
}

// ============================================================================
// MESSAGE LIST (GIỮ NGUYÊN)
// ============================================================================
class _MessageList extends HookConsumerWidget {
  final AsyncValue<List<Message>> messagesAsync;
  final dynamic me;
  final ScrollController scrollController;
  final Function(Message) onReply;
  final Function(Message, String) onReactionTap;
  final Function(Message) onAddReaction;
  final Function(Message) onEdit;
  final Function(Message) onDelete;

  const _MessageList({
    required this.messagesAsync,
    required this.me,
    required this.scrollController,
    required this.onReply,
    required this.onReactionTap,
    required this.onAddReaction,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return messagesAsync.when(
      data: (messages) {
        return ListView.builder(
          controller: scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final m = messages[index];
            final isMe = m.senderId == me?.id;
            bool showAvatar = !isMe;
            if (index > 0 && messages[index - 1].senderId == m.senderId) showAvatar = false;
            // Khoảng cách giữa các tin nhắn
            double marginBottom = (index > 0 && messages[index - 1].senderId != m.senderId) ? 8.0 : 0.0;

            return Padding(
              padding: EdgeInsets.only(bottom: marginBottom),
              child: Row(
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!isMe) ...[
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: showAvatar
                          ? UserAvatar(
                              displayName: m.senderFullName ?? 'U',
                              // ignore: deprecated_member_use
                              avatarUrl: m.sender?.avatarUrl,
                              radius: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: MessageBubble(
                      message: m,
                      isMe: isMe,
                      currentUserId: me?.id,
                      onReply: () => onReply(m),
                      onReactionTap: (e) => onReactionTap(m, e),
                      onAddReaction: () => onAddReaction(m),
                      onEdit: isMe ? () => onEdit(m) : null,
                      onDelete: isMe ? () => onDelete(m) : null,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox(),
    );
  }
}

// ============================================================================
// GALLERY & INPUT BAR (GIỮ NGUYÊN)
// ============================================================================
class _RealMediaGallery extends StatelessWidget {
  final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  final List<AssetEntity> assets;
  final List<AssetEntity> selectedAssets;
  final VoidCallback onCameraTap;
  final Function(AssetPathEntity) onAlbumChanged;
  final Function(AssetEntity) onAssetSelect;

  const _RealMediaGallery({
    required this.albums,
    required this.currentAlbum,
    required this.assets,
    required this.selectedAssets,
    required this.onCameraTap,
    required this.onAlbumChanged,
    required this.onAssetSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDark ? Colors.black12 : Colors.grey[100],
            border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AssetPathEntity>(
              value: currentAlbum,
              isDense: true,
              isExpanded: true,
              dropdownColor: isDark ? const Color(0xFF2C2C2E) : Colors.white,
              items: albums
                  .map(
                    (album) => DropdownMenuItem(
                      value: album,
                      child: FutureBuilder<int>(
                        future: album.assetCountAsync,
                        initialData: 0,
                        builder: (ctx, snap) => Text(
                          "${album.name} (${snap.data})",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) onAlbumChanged(val);
              },
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            key: const PageStorageKey('media_gallery'),
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: assets.length + 1,
            itemBuilder: (context, index) {
              if (index == 0)
                return GestureDetector(
                  onTap: onCameraTap,
                  child: Container(
                    color: Colors.grey[800],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white),
                        Text("Camera", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              final asset = assets[index - 1];
              return _MediaGridItem(
                asset: asset,
                isSelected: selectedAssets.contains(asset),
                onTap: () => onAssetSelect(asset),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MediaGridItem extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final VoidCallback onTap;

  const _MediaGridItem({required this.asset, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _AssetThumbnail(asset: asset),
          if (isSelected) Container(color: Colors.white.withValues(alpha: 0.4)),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ),
          if (asset.type == AssetType.video)
            Positioned(
              bottom: 4,
              right: 4,
              child: Text(
                _formatDuration(asset.duration),
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDuration(int s) =>
      '${(Duration(seconds: s)).inMinutes}:${(Duration(seconds: s).inSeconds % 60).toString().padLeft(2, '0')}';
}

class _AssetThumbnail extends StatefulWidget {
  final AssetEntity asset;

  const _AssetThumbnail({required this.asset});

  @override
  State<_AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<_AssetThumbnail> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final bytes = await widget.asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
    if (mounted) setState(() => _bytes = bytes);
  }

  @override
  Widget build(BuildContext context) => _bytes == null
      ? Container(color: Colors.grey[300])
      : Image.memory(_bytes!, fit: BoxFit.cover, gaplessPlayback: true);
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.chatId,
    required this.isDark,
    required this.primaryColor,
    required this.showGallery,
    required this.canSendMessage,
    required this.onToggleGallery,
    required this.isRecording,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function({String? specificContent, String type, String? mediaUrl, int? duration}) onSend;
  final String chatId;
  final bool isDark;
  final Color primaryColor;
  final bool showGallery;
  final bool canSendMessage;
  final VoidCallback onToggleGallery;
  final ValueNotifier<bool> isRecording;

  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(10, position.top - 120, 100, position.top),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
      items: [
        PopupMenuItem(
          value: 'camera',
          child: Row(
            children: [
              Icon(Icons.camera_alt, color: primaryColor),
              const SizedBox(width: 10),
              const Text("Camera"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'file',
          child: Row(
            children: [
              Icon(Icons.insert_drive_file, color: primaryColor),
              const SizedBox(width: 10),
              const Text("Files"),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1), width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // + button
            Builder(
              builder: (c) => IconButton(
                icon: Icon(Icons.add_circle_outline, color: primaryColor, size: 28),
                onPressed: () => _showMenu(c),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Gallery button
            Container(
              decoration: BoxDecoration(
                color: showGallery ? primaryColor.withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.image_outlined, color: primaryColor, size: 26),
                onPressed: onToggleGallery,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            // Mic button (when no text)
            if (!canSendMessage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onLongPressStart: (_) => isRecording.value = true,
                  onLongPressEnd: (_) => isRecording.value = false,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isRecording.value ? primaryColor.withOpacity(0.1) : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.mic_none, color: primaryColor, size: 26),
                  ),
                ),
              ),
            // Text input
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 40, maxHeight: 120),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF303030) : const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: isRecording.value ? 'Đang ghi âm...' : 'Aa',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
            ),
            // Like button (when no text)
            if (!canSendMessage)
              IconButton(
                icon: Icon(Icons.thumb_up_outlined, color: primaryColor, size: 24),
                onPressed: () {
                  // Send like emoji
                  onSend(specificContent: '👍', type: 'TEXT');
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            // Send button (when has text)
            if (canSendMessage)
              IconButton(
                icon: Icon(Icons.send, color: primaryColor),
                onPressed: () => onSend(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
          ],
        ),
      ),
    );
  }
}

extension ListLookup on List<dynamic> {
  dynamic lookup(String id) {
    if (isEmpty) return null;
    try {
      return firstWhere((e) => e.id.toString() == id);
    } catch (_) {
      return null;
    }
  }
}

void showReactionPicker(BuildContext context, Function(String) onReactionSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (c) => Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['👍', '❤️', '😂', '😮', '😢', '😡']
            .map(
              (e) => GestureDetector(
                onTap: () {
                  onReactionSelected(e);
                  Navigator.pop(c);
                },
                child: Text(e, style: const TextStyle(fontSize: 28)),
              ),
            )
            .toList(),
      ),
    ),
  );
}
