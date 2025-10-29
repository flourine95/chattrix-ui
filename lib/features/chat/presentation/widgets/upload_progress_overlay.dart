import 'package:flutter/material.dart';

/// Overlay widget to show upload progress
class UploadProgressOverlay extends StatelessWidget {
  const UploadProgressOverlay({
    super.key,
    required this.progress,
    required this.fileName,
    this.onCancel,
  });

  final double progress; // 0.0 to 1.0
  final String fileName;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: colors.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uploading',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      fileName,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (onCancel != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onCancel,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: colors.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
          const SizedBox(height: 8),
          // Progress text
          Text(
            '${(progress * 100).toStringAsFixed(0)}%',
            style: textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Show upload progress overlay
OverlayEntry showUploadProgress(
  BuildContext context, {
  required String fileName,
  VoidCallback? onCancel,
}) {
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: UploadProgressOverlay(
        progress: 0.0,
        fileName: fileName,
        onCancel: onCancel,
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);
  return overlayEntry;
}

/// Update upload progress
void updateUploadProgress(
  OverlayEntry overlayEntry,
  double progress,
  String fileName,
  VoidCallback? onCancel,
) {
  overlayEntry.markNeedsBuild();
}

/// Upload progress notifier for managing upload state
class UploadProgressNotifier extends ValueNotifier<UploadProgress?> {
  UploadProgressNotifier() : super(null);

  void startUpload(String fileName) {
    value = UploadProgress(
      fileName: fileName,
      progress: 0.0,
      isUploading: true,
    );
  }

  void updateProgress(double progress) {
    if (value != null) {
      value = value!.copyWith(progress: progress);
    }
  }

  void completeUpload() {
    value = null;
  }

  void cancelUpload() {
    value = null;
  }
}

/// Upload progress state
class UploadProgress {
  final String fileName;
  final double progress;
  final bool isUploading;
  final String? error;

  const UploadProgress({
    required this.fileName,
    required this.progress,
    required this.isUploading,
    this.error,
  });

  UploadProgress copyWith({
    String? fileName,
    double? progress,
    bool? isUploading,
    String? error,
  }) {
    return UploadProgress(
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      isUploading: isUploading ?? this.isUploading,
      error: error ?? this.error,
    );
  }
}

/// Widget to show upload progress in the UI
class UploadProgressWidget extends StatelessWidget {
  const UploadProgressWidget({
    super.key,
    required this.uploadProgress,
    this.onCancel,
  });

  final UploadProgress? uploadProgress;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    if (uploadProgress == null || !uploadProgress!.isUploading) {
      return const SizedBox.shrink();
    }

    return UploadProgressOverlay(
      progress: uploadProgress!.progress,
      fileName: uploadProgress!.fileName,
      onCancel: onCancel,
    );
  }
}

