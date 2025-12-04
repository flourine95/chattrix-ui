import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Page displayed when receiving an incoming call
class IncomingCallPage extends ConsumerWidget {
  const IncomingCallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callProvider);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: callState.when(
          idle: () => const Center(
            child: Text(
              'No incoming call',
              style: TextStyle(color: Colors.white),
            ),
          ),
          initiating: (calleeId, callType) => const SizedBox.shrink(),
          ringing: (invitation) => _buildRingingView(
            context,
            ref,
            callerName: invitation.callerName,
            callerAvatar: invitation.callerAvatar,
            callType: invitation.callType,
          ),
          connecting: (connection, callType, isOutgoing) => const SizedBox.shrink(),
          connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled,
                  isSpeakerEnabled, isFrontCamera, remoteUid) =>
              const SizedBox.shrink(),
          ended: (reason) => const Center(
            child: Text(
              'Call ended',
              style: TextStyle(color: Colors.white),
            ),
          ),
          error: (message) => Center(
            child: Text(
              'Error: $message',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRingingView(
    BuildContext context,
    WidgetRef ref, {
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Caller avatar with pulse animation
          _PulsingAvatar(
            callerName: callerName,
            callerAvatar: callerAvatar,
          ),
          const SizedBox(height: 32),

          // Caller name
          Text(
            callerName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Call type
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                callType == CallType.video ? Icons.videocam : Icons.phone,
                color: Colors.white70,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                callType == CallType.video
                    ? 'Incoming Video Call'
                    : 'Incoming Voice Call',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Reject button
              _CallActionButton(
                label: 'Decline',
                icon: Icons.call_end,
                color: Colors.red,
                onPressed: () => ref.read(callProvider.notifier).rejectCall(),
              ),

              // Accept button
              _CallActionButton(
                label: 'Accept',
                icon: Icons.call,
                color: Colors.green,
                onPressed: () => ref.read(callProvider.notifier).acceptCall(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PulsingAvatar extends StatefulWidget {
  final String callerName;
  final String? callerAvatar;

  const _PulsingAvatar({
    required this.callerName,
    this.callerAvatar,
  });

  @override
  State<_PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<_PulsingAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Colors.grey[800],
        backgroundImage:
            widget.callerAvatar != null ? NetworkImage(widget.callerAvatar!) : null,
        child: widget.callerAvatar == null
            ? Text(
                widget.callerName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 64, color: Colors.white),
              )
            : null,
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CallActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

