import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
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

              AppInputField(labelText: 'Email or Username', controller: emailController, useModernStyle: true),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Password',
                isPassword: true,
                controller: passwordController,
                useModernStyle: true,
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(AppRouter.forgotPasswordPath),
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                  ),
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
                    AppToast.warning(context, title: 'Missing Fields', description: 'Please fill in all fields');
                    return;
                  }

                  final success = await ref
                      .read(authProvider.notifier)
                      .login(usernameOrEmail: email, password: password);

                  if (!context.mounted) return;

                  if (success) {
                    final user = ref.read(currentUserProvider);

                    if (user != null) {
                      AppToast.success(context, title: 'Welcome back!', description: 'Logged in successfully');
                      context.go('/');
                    } else {
                      AppToast.error(
                        context,
                        title: 'Profile Load Failed',
                        description: 'Login successful but failed to load profile. Please try again.',
                      );
                    }
                  } else {
                    final error = ref.read(authErrorProvider);

                    if (error != null && error.contains('Email not verified')) {
                      AppToast.warning(context, title: 'Email Not Verified', description: error);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (context.mounted) {
                          context.push(AppRouter.otpVerificationPath, extra: email);
                        }
                      });
                    } else {
                      AppToast.error(
                        context,
                        title: 'Login Failed',
                        description: error ?? 'Invalid credentials. Please try again.',
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 40),

              const _OrDivider(),
              const SizedBox(height: 30),

              SocialLoginButton(
                icon: FontAwesomeIcons.google,
                text: 'Continue with Google',
                onPressed: () {
                  AppToast.info(context, title: 'Coming Soon', description: 'Google login will be available soon');
                },
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                icon: FontAwesomeIcons.apple,
                text: 'Continue with Apple',
                onPressed: () {
                  AppToast.info(context, title: 'Coming Soon', description: 'Apple login will be available soon');
                },
              ),
              const SizedBox(height: 16),
              SocialLoginButton(
                icon: FontAwesomeIcons.facebook,
                text: 'Continue with Facebook',
                onPressed: () {
                  AppToast.info(context, title: 'Coming Soon', description: 'Facebook login will be available soon');
                },
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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 14),
          ),
          TextButton(
            onPressed: () => context.go(AppRouter.registerPath),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.grey[700]!.withValues(alpha: 0.5) : Colors.grey[300]!.withValues(alpha: 0.8);

    return Row(
      children: [
        Expanded(child: Container(height: 1, color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: dividerColor)),
      ],
    );
  }
}
