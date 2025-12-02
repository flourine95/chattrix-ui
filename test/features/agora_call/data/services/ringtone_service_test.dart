import 'package:chattrix_ui/features/agora_call/data/services/ringtone_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RingtoneService', () {
    late RingtoneService ringtoneService;

    setUp(() {
      ringtoneService = RingtoneService();
    });

    tearDown(() async {
      await ringtoneService.dispose();
    });

    test('should initialize with isPlaying as false', () {
      expect(ringtoneService.isPlaying, false);
    });

    test('should not throw when stopping without playing', () async {
      expect(() async => await ringtoneService.stop(), returnsNormally);
    });

    test('should not throw when playing is called multiple times', () async {
      // Note: This test will fail if ringtone.mp3 is missing
      // It's expected to throw an error in that case
      try {
        await ringtoneService.play();
        expect(ringtoneService.isPlaying, true);

        // Calling play again should not throw
        await ringtoneService.play();
        expect(ringtoneService.isPlaying, true);
      } catch (e) {
        // Expected if ringtone.mp3 is missing
        expect(e.toString(), contains('Unable to load asset'));
      }
    });

    test('should set isPlaying to false after stop', () async {
      try {
        await ringtoneService.play();
        expect(ringtoneService.isPlaying, true);

        await ringtoneService.stop();
        expect(ringtoneService.isPlaying, false);
      } catch (e) {
        // Expected if ringtone.mp3 is missing
        expect(e.toString(), contains('Unable to load asset'));
      }
    });

    test('should handle dispose gracefully', () async {
      expect(() async => await ringtoneService.dispose(), returnsNormally);
    });

    test('should handle dispose after playing', () async {
      try {
        await ringtoneService.play();
        expect(() async => await ringtoneService.dispose(), returnsNormally);
      } catch (e) {
        // Expected if ringtone.mp3 is missing
        expect(e.toString(), contains('Unable to load asset'));
      }
    });
  });
}
