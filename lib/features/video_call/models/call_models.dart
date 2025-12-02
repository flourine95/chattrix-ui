// Simple models without freezed - để tránh phức tạp
enum CallType {
  audio,
  video;

  String toJson() => name.toUpperCase();

  static CallType fromJson(String value) {
    return CallType.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => CallType.audio,
    );
  }
}

enum CallStatus {
  ringing,
  connecting,
  connected,
  rejected,
  ended,
  initiating;

  static CallStatus fromJson(String value) {
    return CallStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => CallStatus.initiating,
    );
  }
}

enum RejectReason {
  busy,
  declined,
  unavailable;

  String toJson() => name;

  static RejectReason fromJson(String value) {
    return RejectReason.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RejectReason.declined,
    );
  }
}

class CallUser {
  final int id;
  final String name;
  final String? avatarUrl;

  CallUser({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  factory CallUser.fromJson(Map<String, dynamic> json) {
    return CallUser(
      id: json['id'] as int,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatarUrl': avatarUrl,
      };
}

class CallInfo {
  final String id;
  final String channelId;
  final CallStatus status;
  final CallType callType;
  final CallUser caller;
  final CallUser callee;
  final DateTime createdAt;
  final int? durationSeconds;

  CallInfo({
    required this.id,
    required this.channelId,
    required this.status,
    required this.callType,
    required this.caller,
    required this.callee,
    required this.createdAt,
    this.durationSeconds,
  });

  factory CallInfo.fromJson(Map<String, dynamic> json) {
    return CallInfo(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      status: CallStatus.fromJson(json['status'] as String),
      callType: CallType.fromJson(json['callType'] as String),
      caller: CallUser.fromJson({
        'id': json['callerId'],
        'name': json['callerName'],
        'avatarUrl': json['callerAvatar'],
      }),
      callee: CallUser.fromJson({
        'id': json['calleeId'],
        'name': json['calleeName'],
        'avatarUrl': json['calleeAvatar'],
      }),
      createdAt: DateTime.parse(json['createdAt'] as String),
      durationSeconds: json['durationSeconds'] as int?,
    );
  }
}

class CallConnection {
  final CallInfo callInfo;
  final String token;

  CallConnection({
    required this.callInfo,
    required this.token,
  });

  factory CallConnection.fromJson(Map<String, dynamic> json) {
    return CallConnection(
      callInfo: CallInfo.fromJson(json['callInfo'] as Map<String, dynamic>),
      token: json['token'] as String,
    );
  }
}

// Request models
class InitiateCallRequest {
  final int calleeId;
  final CallType callType;

  InitiateCallRequest({
    required this.calleeId,
    required this.callType,
  });

  Map<String, dynamic> toJson() => {
        'calleeId': calleeId,
        'callType': callType.toJson(),
      };
}

class RejectCallRequest {
  final RejectReason reason;

  RejectCallRequest({required this.reason});

  Map<String, dynamic> toJson() => {
        'reason': reason.toJson(),
      };
}

class EndCallRequest {
  final String reason;

  EndCallRequest({this.reason = 'hangup'});

  Map<String, dynamic> toJson() => {
        'reason': reason,
      };
}

// WebSocket event models
class CallInvitation {
  final String callId;
  final String channelId;
  final int callerId;
  final String callerName;
  final String? callerAvatar;
  final CallType callType;

  CallInvitation({
    required this.callId,
    required this.channelId,
    required this.callerId,
    required this.callerName,
    this.callerAvatar,
    required this.callType,
  });

  factory CallInvitation.fromJson(Map<String, dynamic> json) {
    return CallInvitation(
      callId: json['callId'] as String,
      channelId: json['channelId'] as String,
      callerId: json['callerId'] as int,
      callerName: json['callerName'] as String,
      callerAvatar: json['callerAvatar'] as String?,
      callType: CallType.fromJson(json['callType'] as String),
    );
  }
}

class CallAccept {
  final String callId;
  final int acceptedBy;

  CallAccept({
    required this.callId,
    required this.acceptedBy,
  });

  factory CallAccept.fromJson(Map<String, dynamic> json) {
    return CallAccept(
      callId: json['callId'] as String,
      acceptedBy: json['acceptedBy'] as int,
    );
  }
}

class CallReject {
  final String callId;
  final int rejectedBy;
  final RejectReason reason;

  CallReject({
    required this.callId,
    required this.rejectedBy,
    required this.reason,
  });

  factory CallReject.fromJson(Map<String, dynamic> json) {
    return CallReject(
      callId: json['callId'] as String,
      rejectedBy: json['rejectedBy'] as int,
      reason: RejectReason.fromJson(json['reason'] as String),
    );
  }
}

class CallEnd {
  final String callId;
  final int endedBy;
  final int durationSeconds;

  CallEnd({
    required this.callId,
    required this.endedBy,
    required this.durationSeconds,
  });

  factory CallEnd.fromJson(Map<String, dynamic> json) {
    return CallEnd(
      callId: json['callId'] as String,
      endedBy: json['endedBy'] as int,
      durationSeconds: json['durationSeconds'] as int,
    );
  }
}

class CallTimeout {
  final String callId;
  final String reason;

  CallTimeout({
    required this.callId,
    required this.reason,
  });

  factory CallTimeout.fromJson(Map<String, dynamic> json) {
    return CallTimeout(
      callId: json['callId'] as String,
      reason: json['reason'] as String,
    );
  }
}

