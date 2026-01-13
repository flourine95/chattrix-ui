import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

/// Gallery widget for selecting media from device
class ChatGallery extends StatelessWidget {
  final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  final List<AssetEntity> assets;
  final List<AssetEntity> selectedAssets;
  final VoidCallback onCameraTap;
  final Function(AssetPathEntity) onAlbumChanged;
  final Function(AssetEntity) onAssetSelect;

  const ChatGallery({
    super.key,
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
              if (index == 0) {
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
              }
              final asset = assets[index - 1];
              return MediaGridItem(
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

class MediaGridItem extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final VoidCallback onTap;

  const MediaGridItem({super.key, required this.asset, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AssetThumbnail(asset: asset),
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

class AssetThumbnail extends StatefulWidget {
  final AssetEntity asset;

  const AssetThumbnail({super.key, required this.asset});

  @override
  State<AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<AssetThumbnail> {
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
