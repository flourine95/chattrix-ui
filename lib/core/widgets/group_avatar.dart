import 'package:chattrix_ui/core/widgets/user_avatar.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:flutter/material.dart';

/// Group avatar widget that displays stacked avatars of group members
class GroupAvatar extends StatelessWidget {
  final List<Participant> participants;
  final double radius;
  final int maxAvatars;
  final bool showBorder;
  final Color? borderColor;

  const GroupAvatar({
    super.key,
    required this.participants,
    this.radius = 60,
    this.maxAvatars = 4,
    this.showBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    // If only one participant or empty, show single avatar
    if (participants.isEmpty) {
      return UserAvatar(
        displayName: 'Group',
        avatarUrl: null,
        radius: radius,
        backgroundColor: colors.primary,
      );
    }

    if (participants.length == 1) {
      return UserAvatar(
        displayName: participants.first.fullName,
        avatarUrl: participants.first.avatarUrl,
        radius: radius,
        backgroundColor: colors.primary,
      );
    }

    // For 2 participants, show side by side
    if (participants.length == 2) {
      return _buildTwoAvatars(context);
    }

    // For 3+ participants, show in grid
    return _buildGridAvatars(context);
  }

  Widget _buildTwoAvatars(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final avatarSize = radius * 0.7;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder ? Border.all(color: borderColor ?? colors.surface, width: 3) : null,
      ),
      child: ClipOval(
        child: Row(
          children: [
            Expanded(
              child: UserAvatar(
                displayName: participants[0].fullName,
                avatarUrl: participants[0].avatarUrl,
                radius: avatarSize,
              ),
            ),
            Expanded(
              child: UserAvatar(
                displayName: participants[1].fullName,
                avatarUrl: participants[1].avatarUrl,
                radius: avatarSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridAvatars(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final displayParticipants = participants.take(maxAvatars).toList();
    final avatarSize = radius * 0.6;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.surface,
        border: showBorder ? Border.all(color: borderColor ?? colors.surface, width: 3) : null,
      ),
      child: ClipOval(
        child: GridView.count(
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          children: displayParticipants.map((participant) {
            return UserAvatar(
              displayName: participant.fullName,
              avatarUrl: participant.avatarUrl,
              radius: avatarSize,
            );
          }).toList(),
        ),
      ),
    );
  }
}

