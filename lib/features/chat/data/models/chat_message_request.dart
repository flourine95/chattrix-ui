class ChatMessageRequest {
  final String content;
  final String type; // 'TEXT', 'IMAGE', 'AUDIO', 'VIDEO', 'FILE', 'LOCATION'
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? fileName;
  final int? fileSize;
  final int? duration;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final int? replyToMessageId;
  final List<int>? mentions;

  ChatMessageRequest({
    required this.content,
    this.type = 'TEXT',
    this.mediaUrl,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    this.duration,
    this.latitude,
    this.longitude,
    this.locationName,
    this.replyToMessageId,
    this.mentions,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'type': type,
      if (mediaUrl != null) 'mediaUrl': mediaUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (fileName != null) 'fileName': fileName,
      if (fileSize != null) 'fileSize': fileSize,
      if (duration != null) 'duration': duration,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (locationName != null) 'locationName': locationName,
      if (replyToMessageId != null) 'replyToMessageId': replyToMessageId,
      if (mentions != null) 'mentions': mentions,
    };
  }
}
