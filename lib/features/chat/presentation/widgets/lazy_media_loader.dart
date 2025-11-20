import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A widget that lazily loads its child when it becomes visible in the viewport
/// This is used to optimize performance by only loading media when needed
class LazyMediaLoader extends StatefulWidget {
  const LazyMediaLoader({super.key, required this.child, required this.placeholder, this.visibilityThreshold = 0.1});

  /// The widget to load when visible (e.g., image or video player)
  final Widget child;

  /// The placeholder to show before the media is loaded
  final Widget placeholder;

  /// The fraction of the widget that must be visible to trigger loading (0.0 to 1.0)
  final double visibilityThreshold;

  @override
  State<LazyMediaLoader> createState() => _LazyMediaLoaderState();
}

class _LazyMediaLoaderState extends State<LazyMediaLoader> {
  bool _isVisible = false;
  bool _hasBeenVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    // Only load once when the widget becomes visible
    if (!_hasBeenVisible && info.visibleFraction >= widget.visibilityThreshold) {
      setState(() {
        _isVisible = true;
        _hasBeenVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: _isVisible ? widget.child : widget.placeholder,
    );
  }
}
