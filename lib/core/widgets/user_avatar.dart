import 'dart:io';
import 'package:chattrix_ui/core/utils/avatar_generator.dart';
import 'package:flutter/material.dart';

/// Reusable avatar widget that handles both network URLs and local files
/// Falls back to generated initials if no image is available
class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String? localAvatarPath;
  final String displayName;
  final double radius;
  final Color? backgroundColor;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;

  const UserAvatar({
    super.key,
    this.avatarUrl,
    this.localAvatarPath,
    required this.displayName,
    this.radius = 20,
    this.backgroundColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final initials = AvatarGenerator.getInitials(displayName);
    final bgColor = backgroundColor ?? AvatarGenerator.generateColor(displayName);

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      backgroundImage: _getImageProvider(),
      child: _getImageProvider() == null
          ? Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: radius * 0.6,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );

    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
            width: borderWidth,
          ),
        ),
        child: avatar,
      );
    }

    return avatar;
  }

  ImageProvider? _getImageProvider() {
    // Priority: localAvatarPath > avatarUrl
    if (localAvatarPath != null && localAvatarPath!.isNotEmpty) {
      return FileImage(File(localAvatarPath!));
    }

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    }

    return null;
  }
}

