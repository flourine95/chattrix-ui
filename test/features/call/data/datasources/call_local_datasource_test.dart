import 'package:chattrix_ui/features/call/data/datasources/call_local_datasource_impl.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_history_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CallLocalDataSourceImpl dataSource;
  late FlutterSecureStorage secureStorage;

  setUp(() {
    // Initialize with mock secure storage
    FlutterSecureStorage.setMockInitialValues({});
    secureStorage = const FlutterSecureStorage();
    dataSource = CallLocalDataSourceImpl(secureStorage: secureStorage);
  });

  group('CallLocalDataSource', () {
    test('should save and retrieve call history', () async {
      // Arrange
      final callHistory = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connected,
        timestamp: DateTime(2024, 1, 1, 10, 0),
        durationSeconds: 120,
      );

      // Act
      await dataSource.saveCallHistory(callHistory);
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result.length, 1);
      expect(result.first.id, 'test-call-1');
      expect(result.first.remoteUserId, 'user-123');
      expect(result.first.remoteUserName, 'John Doe');
      expect(result.first.callType, CallType.video);
      expect(result.first.status, CallStatus.connected);
      expect(result.first.durationSeconds, 120);
    });

    test('should return empty list when no call history exists', () async {
      // Act
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result, isEmpty);
    });

    test('should save multiple call history entries', () async {
      // Arrange
      final callHistory1 = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connected,
        timestamp: DateTime(2024, 1, 1, 10, 0),
        durationSeconds: 120,
      );

      final callHistory2 = CallHistoryEntity(
        id: 'test-call-2',
        remoteUserId: 'user-456',
        remoteUserName: 'Jane Smith',
        callType: CallType.audio,
        status: CallStatus.missed,
        timestamp: DateTime(2024, 1, 2, 14, 30),
      );

      // Act
      await dataSource.saveCallHistory(callHistory1);
      await dataSource.saveCallHistory(callHistory2);
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result.length, 2);
      expect(result[0].id, 'test-call-1');
      expect(result[1].id, 'test-call-2');
    });

    test('should update existing call history entry', () async {
      // Arrange
      final callHistory = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connecting,
        timestamp: DateTime(2024, 1, 1, 10, 0),
      );

      final updatedCallHistory = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connected,
        timestamp: DateTime(2024, 1, 1, 10, 0),
        durationSeconds: 180,
      );

      // Act
      await dataSource.saveCallHistory(callHistory);
      await dataSource.saveCallHistory(updatedCallHistory);
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result.length, 1);
      expect(result.first.status, CallStatus.connected);
      expect(result.first.durationSeconds, 180);
    });

    test('should delete specific call history entry', () async {
      // Arrange
      final callHistory1 = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connected,
        timestamp: DateTime(2024, 1, 1, 10, 0),
        durationSeconds: 120,
      );

      final callHistory2 = CallHistoryEntity(
        id: 'test-call-2',
        remoteUserId: 'user-456',
        remoteUserName: 'Jane Smith',
        callType: CallType.audio,
        status: CallStatus.missed,
        timestamp: DateTime(2024, 1, 2, 14, 30),
      );

      // Act
      await dataSource.saveCallHistory(callHistory1);
      await dataSource.saveCallHistory(callHistory2);
      await dataSource.deleteCallHistory('test-call-1');
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result.length, 1);
      expect(result.first.id, 'test-call-2');
    });

    test('should clear all call history', () async {
      // Arrange
      final callHistory1 = CallHistoryEntity(
        id: 'test-call-1',
        remoteUserId: 'user-123',
        remoteUserName: 'John Doe',
        callType: CallType.video,
        status: CallStatus.connected,
        timestamp: DateTime(2024, 1, 1, 10, 0),
        durationSeconds: 120,
      );

      final callHistory2 = CallHistoryEntity(
        id: 'test-call-2',
        remoteUserId: 'user-456',
        remoteUserName: 'Jane Smith',
        callType: CallType.audio,
        status: CallStatus.missed,
        timestamp: DateTime(2024, 1, 2, 14, 30),
      );

      // Act
      await dataSource.saveCallHistory(callHistory1);
      await dataSource.saveCallHistory(callHistory2);
      await dataSource.clearCallHistory();
      final result = await dataSource.getCallHistory();

      // Assert
      expect(result, isEmpty);
    });
  });
}
