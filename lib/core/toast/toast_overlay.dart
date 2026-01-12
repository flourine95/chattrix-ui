import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'toast_controller.dart';
import 'toast_type.dart';

enum ToastPosition { topLeft, topCenter, topRight, bottomLeft, bottomCenter, bottomRight }

class ToastOverlay extends StatelessWidget {
  const ToastOverlay({
    super.key,
    required this.child,
    this.position = ToastPosition.bottomRight,
    this.margin = const EdgeInsets.all(12),
  });

  final Widget child;
  final ToastPosition position;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        _ToastViewport(position: position, margin: margin),
      ],
    );
  }
}

class _ToastViewport extends ConsumerWidget {
  const _ToastViewport({required this.position, required this.margin});

  final ToastPosition position;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(toastControllerProvider);

    if (controller.toasts.isEmpty) return const SizedBox.shrink();

    Alignment alignmentFor(ToastPosition pos) {
      switch (pos) {
        case ToastPosition.topLeft:
          return Alignment.topLeft;
        case ToastPosition.topCenter:
          return Alignment.topCenter;
        case ToastPosition.topRight:
          return Alignment.topRight;
        case ToastPosition.bottomLeft:
          return Alignment.bottomLeft;
        case ToastPosition.bottomCenter:
          return Alignment.bottomCenter;
        case ToastPosition.bottomRight:
          return Alignment.bottomRight;
      }
    }

    EdgeInsets paddingFor(ToastPosition pos, EdgeInsets base) {
      final lr = EdgeInsets.only(left: base.left, right: base.right);
      if (pos == ToastPosition.topLeft || pos == ToastPosition.topCenter || pos == ToastPosition.topRight) {
        return lr.copyWith(top: base.top);
      } else {
        return lr.copyWith(bottom: base.bottom);
      }
    }

    return IgnorePointer(
      ignoring: false,
      child: SafeArea(
        child: Align(
          alignment: alignmentFor(position),
          child: Padding(
            padding: paddingFor(position, margin),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final e in controller.toasts)
                    _ToastItem(
                      key: ValueKey(e.id),
                      entry: e,
                      onClose: () => ref.read(toastControllerProvider).dismiss(e.id),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastItem extends StatefulWidget {
  const _ToastItem({super.key, required this.entry, required this.onClose});

  final ToastEntry entry;
  final VoidCallback onClose;

  @override
  State<_ToastItem> createState() => _ToastItemState();
}

class _ToastItemState extends State<_ToastItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _slide = Tween<Offset>(
      begin: const Offset(0.08, -0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final isDark = brightness == Brightness.dark;

    final accent = toastAccentColor(widget.entry.type, brightness);

    final bg = isDark ? const Color(0xFF0B0B0B) : Colors.white;
    final onBg = isDark ? Colors.white : Colors.black;
    final border = isDark ? const Color(0x1FFFFFFF) : const Color(0x14000000);

    final iconBg = Color.alphaBlend(accent.withValues(alpha: isDark ? 0.18 : 0.10), bg);

    return AnimatedSlide(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      offset: widget.entry.dismissed ? const Offset(0.06, -0.04) : Offset.zero,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        opacity: widget.entry.dismissed ? 0.0 : 1.0,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: bg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: border),
                  ),
                  shadows: [
                    BoxShadow(
                      color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.06),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: iconBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: accent.withValues(alpha: 0.28)),
                              ),
                              child: Icon(toastIcon(widget.entry.type), color: accent, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.entry.title,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onBg,
                                    ),
                                  ),
                                  if (widget.entry.description != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.entry.description!,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        height: 1.25,
                                        color: onBg.withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Close
                            Material(
                              type: MaterialType.transparency,
                              child: InkResponse(
                                onTap: widget.onClose,
                                radius: 18,
                                child: Icon(Icons.close_rounded, size: 18, color: onBg.withValues(alpha: 0.7)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Progress bar
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _ProgressBar(
                          color: accent,
                          startedAt: widget.entry.createdAt,
                          duration: widget.entry.duration,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatefulWidget {
  const _ProgressBar({required this.color, required this.startedAt, required this.duration});

  final Color color;
  final DateTime startedAt;
  final Duration duration;

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<_ProgressBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 3,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final value = 1.0 - _controller.value;
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.color.withValues(alpha: isDark ? 0.9 : 0.85),
                    widget.color.withValues(alpha: isDark ? 0.55 : 0.4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
