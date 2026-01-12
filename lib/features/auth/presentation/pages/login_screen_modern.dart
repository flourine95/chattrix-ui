import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Modern login screen using Riverpod 3 AsyncNotifier pattern
///
/// Key improvements:
/// - Uses AsyncValue for automatic loading/error state management
/// - Cleaner error handling with exceptions
/// - Less boilerplate code
/// - Type-safe provider access
class LoginScreenModern extends HookConsumerWidget {
  const LoginScreenModern({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Watch auth state - AsyncValue automatically handles loading/error
    final authAsync = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // Header
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your credentials to continue',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
              const SizedBox(height: 40),

              // Error message display using AsyncValue
              authAsync.whenOrNull(
                    error: (error, stack) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                error.toString(),
                                style: TextStyle(color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) ??
                  const SizedBox.shrink(),

              // Form fields
              AppInputField(labelText: 'Email or Username', controller: emailController),
              const SizedBox(height: 20),

              AppInputField(labelText: 'Password', isPassword: true, controller: passwordController),
              const SizedBox(height: 12),

              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: authAsync.isLoading ? null : () => context.push(AppRouter.forgotPasswordPath),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),

              // Login button - automatically shows loading state
              PrimaryButton(
                text: 'Login',
                isLoading: authAsync.isLoading,
                onPressed: authAsync.isLoading
                    ? null
                    : () => _handleLogin(context, ref, emailController.text.trim(), passwordController.text),
              ),
              const SizedBox(height: 40),

              const _OrDivider(),
              const SizedBox(height: 30),

              // Social login buttons
              SocialLoginButton(icon: FontAwesomeIcons.google, text: 'Continue with Google', onPressed: () {}),
              const SizedBox(height: 16),
              SocialLoginButton(icon: FontAwesomeIcons.apple, text: 'Continue with Apple', onPressed: () {}),
              const SizedBox(height: 16),
              SocialLoginButton(icon: FontAwesomeIcons.facebook, text: 'Continue with Facebook', onPressed: () {}),
              const SizedBox(height: 40),

              _buildSignUpLink(context, authAsync.isLoading),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Handle login with modern async/await pattern
  Future<void> _handleLogin(BuildContext context, WidgetRef ref, String usernameOrEmail, String password) async {
    // Validate input
    if (usernameOrEmail.isEmpty || password.isEmpty) {
      Toasts.error(context, title: 'Error', description: 'Please fill in all fields');
      return;
    }

    try {
      // Call login - AsyncValue.guard will catch any errors
      await ref.read(authProvider.notifier).login(usernameOrEmail: usernameOrEmail, password: password);

      // Success! Check if widget is still mounted
      if (!context.mounted) return;

      // Show success message
      Toasts.success(context, title: 'Success', description: 'Login successful!');

      // Navigate to home - router guard will handle the rest
      context.go('/');
    } catch (e) {
      // Error is already captured in AsyncValue.error
      // Just show a toast for immediate user feedback
      if (!context.mounted) return;

      Toasts.error(context, title: 'Login Failed', description: e.toString());
    }
  }

  Widget _buildSignUpLink(BuildContext context, bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
        TextButton(
          onPressed: isLoading ? null : () => context.go(AppRouter.registerPath),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('OR', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}
