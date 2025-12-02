import 'package:chattrix_ui/features/agora_call/presentation/pages/incoming_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('IncomingCallScreen', () {
    testWidgets('should instantiate IncomingCallScreen widget', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: IncomingCallScreen())));

      // Assert - Widget should be created without errors
      expect(find.byType(IncomingCallScreen), findsOneWidget);
    });

    testWidgets('should display scaffold with safe area', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: IncomingCallScreen())));

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });
  });
}
