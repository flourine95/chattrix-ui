import 'package:chattrix_ui/features/call/presentation/providers/pip_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget that sets up the router reference for PiP navigation
/// This must be placed inside the router context
class RouterSetup extends HookConsumerWidget {
  final Widget child;

  const RouterSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set up router for PiP navigation
    useEffect(() {
      final router = GoRouter.of(context);
      ref.read(pipStateProvider.notifier).setRouter(router);
      debugPrint('[RouterSetup] Router configured for PiP navigation');
      return null;
    }, []);

    return child;
  }
}
