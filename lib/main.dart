import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/theme/app_theme.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/global_pip_overlay.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/scheduled_message_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: ToastificationWrapper(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(webSocketConnectionProvider);
    ref.watch(callProvider);

    ref.watch(scheduledMessageWebSocketListenerProvider);

    return ToastificationConfigProvider(
      config: ToastificationConfig(
        alignment: Alignment.topRight,
        itemWidth: 360,
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: _slideFromRightAnimation,
        marginBuilder: _marginBuilder,
      ),
      child: MaterialApp.router(
        title: 'Chattrix',
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) => GlobalPipOverlay(child: child ?? const SizedBox.shrink()),
        routerConfig: AppRouter.router(ref),
      ),
    );
  }
}

Widget _slideFromRightAnimation(BuildContext context, Animation<double> animation, Alignment alignment, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.25, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
    child: FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
      child: child,
    ),
  );
}

EdgeInsetsGeometry _marginBuilder(BuildContext context, AlignmentGeometry alignment) {
  return const EdgeInsets.only(top: 12, right: 12, left: 12);
}
