import 'package:flutter_test/flutter_test.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';

void main() {
  group('ConversationUtils.formatTimeAgo', () {
    test('should return "0m" for less than 1 minute ago', () {
      final now = DateTime.now();
      final dateTime = now.subtract(const Duration(seconds: 30));

      final result = ConversationUtils.formatTimeAgo(dateTime);

      expect(result, '0m');
    });

    test('should return relative time in minutes for < 1 hour', () {
      final now = DateTime.now();
      final dateTime = now.subtract(const Duration(minutes: 2));

      final result = ConversationUtils.formatTimeAgo(dateTime);

      expect(result, '2m');
    });

    test('should return relative time "45m" for 45 minutes ago', () {
      final now = DateTime.now();
      final dateTime = now.subtract(const Duration(minutes: 45));

      final result = ConversationUtils.formatTimeAgo(dateTime);

      expect(result, '45m');
    });

    test('should return time format "HH:mm" for today', () {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, 14, 30);

      final result = ConversationUtils.formatTimeAgo(dateTime);

      expect(result, '14:30');
    });

    test('should return "Yesterday" for yesterday', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final dateTime = DateTime(yesterday.year, yesterday.month, yesterday.day, 10, 0);

      final result = ConversationUtils.formatTimeAgo(dateTime);

      expect(result, 'Yesterday');
    });

    test('should return day name for this week (within 7 days)', () {
      final now = DateTime.now();
      // Go back 3 days
      final dateTime = now.subtract(const Duration(days: 3));

      final result = ConversationUtils.formatTimeAgo(dateTime);

      // Should be one of the day names
      expect(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].contains(result), true);
    });

    test('should return "Mon" for Monday this week', () {
      // Create a specific Monday date
      final monday = DateTime(2024, 1, 1); // Jan 1, 2024 is a Monday

      final result = ConversationUtils.formatTimeAgo(monday);

      // If it's within 7 days, should return day name
      final now = DateTime.now();
      final difference = now.difference(monday);

      if (difference.inDays < 7 && difference.inDays >= 2) {
        expect(result, 'Mon');
      } else {
        // If it's older, should return date format
        expect(result, 'Jan 1');
      }
    });

    test('should return date format "MMM d" for earlier dates', () {
      final now = DateTime.now();
      final dateTime = now.subtract(const Duration(days: 10));

      final result = ConversationUtils.formatTimeAgo(dateTime);

      // Should match pattern like "Dec 10", "Jan 5", etc.
      final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final expectedMonth = monthNames[dateTime.month - 1];
      final expectedDay = dateTime.day;

      expect(result, '$expectedMonth $expectedDay');
    });

    test('should return "Dec 10" for December 10', () {
      final dateTime = DateTime(2023, 12, 10);

      final result = ConversationUtils.formatTimeAgo(dateTime);

      // Should return date format since it's more than 7 days ago
      expect(result, 'Dec 10');
    });
  });
}
