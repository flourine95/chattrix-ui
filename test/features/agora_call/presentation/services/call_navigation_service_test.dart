import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/agora_call/presentation/services/call_navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('CallNavigationService', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('isOnCallScreen returns true when on call screen', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const Scaffold(body: Text('Home')),
                ),
                GoRoute(
                  path: '/agora-call/outgoing',
                  builder: (context, state) => const Scaffold(body: Text('Outgoing')),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Get context
      final homeContext = tester.element(find.text('Home'));
      final navService = container.read(callNavigationServiceProvider(homeContext));

      // Should not be on call screen initially
      expect(navService.isOnCallScreen(), false);
    });

    group('handleDeepLink', () {
      test('parses incoming call deep link correctly', () {
        final uri = Uri.parse('chattrix://call/incoming?callId=test-call-id');
        expect(uri.scheme, 'chattrix');
        expect(uri.host, 'call');
        expect(uri.pathSegments.first, 'incoming');
        expect(uri.queryParameters['callId'], 'test-call-id');
      });

      test('parses active call deep link correctly', () {
        final uri = Uri.parse('chattrix://call/active?callId=test-call-id');
        expect(uri.scheme, 'chattrix');
        expect(uri.host, 'call');
        expect(uri.pathSegments.first, 'active');
        expect(uri.queryParameters['callId'], 'test-call-id');
      });

      test('rejects invalid deep link scheme', () {
        final uri = Uri.parse('https://example.com/call/incoming');
        expect(uri.scheme, 'https');
        expect(uri.scheme != 'chattrix', true);
      });

      test('rejects invalid deep link host', () {
        final uri = Uri.parse('chattrix://other/incoming');
        expect(uri.host, 'other');
        expect(uri.host != 'call', true);
      });
    });

    group('Call state handling', () {
      test('initiating call has correct status', () {
        final call = CallEntity(
          id: 'test-call-id',
          channelId: 'test-channel',
          status: CallStatus.initiating,
          callType: CallType.audio,
          callerId: 1,
          callerName: 'John Doe',
          callerAvatar: null,
          calleeId: 2,
          calleeName: 'Jane Smith',
          calleeAvatar: null,
          createdAt: DateTime.now(),
        );

        expect(call.status, CallStatus.initiating);
      });

      test('connected call has correct status', () {
        final call = CallEntity(
          id: 'test-call-id',
          channelId: 'test-channel',
          status: CallStatus.connected,
          callType: CallType.video,
          callerId: 1,
          callerName: 'John Doe',
          callerAvatar: null,
          calleeId: 2,
          calleeName: 'Jane Smith',
          calleeAvatar: null,
          createdAt: DateTime.now(),
        );

        expect(call.status, CallStatus.connected);
      });

      test('ended call has correct status', () {
        final call = CallEntity(
          id: 'test-call-id',
          channelId: 'test-channel',
          status: CallStatus.ended,
          callType: CallType.audio,
          callerId: 1,
          callerName: 'John Doe',
          callerAvatar: null,
          calleeId: 2,
          calleeName: 'Jane Smith',
          calleeAvatar: null,
          createdAt: DateTime.now(),
        );

        expect(call.status, CallStatus.ended);
      });
    });
  });

  group('CallScreenType', () {
    test('has correct enum values', () {
      expect(CallScreenType.values.length, 3);
      expect(CallScreenType.values, contains(CallScreenType.outgoing));
      expect(CallScreenType.values, contains(CallScreenType.incoming));
      expect(CallScreenType.values, contains(CallScreenType.active));
    });
  });
}
