import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/toast/toast_overlay.dart';
import 'features/call/presentation/providers/incoming_call_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize IncomingCallProvider to start listening for call invitations
    // This ensures the provider is created and subscribed to callInvitationStream
    // even before any UI component explicitly watches it
    ref.watch(incomingCallProvider);

    return MaterialApp.router(
      title: 'Chattrix',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) => ToastOverlay(child: child ?? const SizedBox.shrink()),
      routerConfig: AppRouter.router(ref),
    );
  }
}
