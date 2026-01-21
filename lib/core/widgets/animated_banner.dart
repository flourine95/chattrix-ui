import 'package:flutter/material.dart';

/// Animated banner that slides from left to right
/// Used for auth screens to show errors, success, and info messages
/// 
/// Design specs from UI_DESIGN_GLOSSARY.md:
/// - Animation: Slide from left to right, 400ms, easeOutCubic
/// - Direction: Offset(-1, 0) → Offset.zero
/// - Padding: horizontal 16px, vertical 12px
/// - Shadow: Black 10% opacity, blur 8, offset (0, 2)
/// - Auto-dismiss: 3-5 seconds
class AnimatedBanner extends StatefulWidget {
  final String message;
  final AnimatedBannerType type;

  const AnimatedBanner({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getBannerConfig(widget.type);

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: config.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Icon(config.icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _BannerConfig _getBannerConfig(AnimatedBannerType type) {
    switch (type) {
      case AnimatedBannerType.error:
        return _BannerConfig(
          backgroundColor: Colors.red.shade600,
          icon: Icons.error_outline,
        );
      case AnimatedBannerType.success:
        return _BannerConfig(
          backgroundColor: Colors.green.shade600,
          icon: Icons.check_circle_outline,
        );
      case AnimatedBannerType.info:
        return _BannerConfig(
          backgroundColor: Colors.blue.shade600,
          icon: Icons.info_outline,
        );
    }
  }
}

class _BannerConfig {
  final Color backgroundColor;
  final IconData icon;

  _BannerConfig({
    required this.backgroundColor,
    required this.icon,
  });
}

enum AnimatedBannerType {
  error,
  success,
  info,
}
