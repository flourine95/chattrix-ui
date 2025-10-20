import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your credentials to continue',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 40),

              AppInputField(
                labelText: 'Email or Username',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Password',
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(AppRouter.forgotPasswordPath),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),

              PrimaryButton(
                text: 'Login',
                isLoading: isLoading,
                onPressed: () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    Toasts.error(
                      context,
                      title: 'Error',
                      description: 'Please fill in all fields',
                    );
                    return;
                  }

                  final success = await ref
                      .read(authNotifierProvider.notifier)
                      .login(usernameOrEmail: email, password: password);

                  if (!context.mounted) return;

                  if (success) {
                    Toasts.success(
                      context,
                      title: 'Success',
                      description: 'Login successful!',
                    );
                    // The router will automatically redirect to home due to the auth guard
                    context.go('/');
                  } else {
                    final error = ref.read(authErrorProvider);
                    Toasts.error(
                      context,
                      title: 'Login Failed',
                      description: error ?? 'An error occurred',
                    );
                  }
                },
              ),
              const SizedBox(height: 40),

              const _OrDivider(),
              const SizedBox(height: 30),

              SocialLoginButton(
                icon: FontAwesomeIcons.google,
                text: 'Continue with Google',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                icon: FontAwesomeIcons.apple,
                text: 'Continue with Apple',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                icon: FontAwesomeIcons.facebook,
                text: 'Continue with Facebook',
                onPressed: () {},
              ),
              const SizedBox(height: 40),

              _buildSignUpLink(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        TextButton(
          onPressed: () => context.go(AppRouter.registerPath),
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
    final dividerColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.2);
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}
