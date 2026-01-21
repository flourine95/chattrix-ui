import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => context.go(AppRouter.loginPath),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
              const SizedBox(height: 40),

              AppInputField(labelText: 'Email', controller: emailController, useModernStyle: true),
              const SizedBox(height: 30),

              PrimaryButton(
                text: 'Send Reset Link',
                isLoading: isLoading,
                onPressed: () async {
                  final email = emailController.text.trim();

                  if (email.isEmpty) {
                    AppToast.warning(context, title: 'Email Required', description: 'Please enter your email');
                    return;
                  }

                  if (!email.contains('@')) {
                    AppToast.warning(
                      context,
                      title: 'Invalid Email',
                      description: 'Please enter a valid email address',
                    );
                    return;
                  }

                  final success = await ref.read(authProvider.notifier).forgotPassword(email: email);

                  if (!context.mounted) return;

                  if (success) {
                    AppToast.success(
                      context,
                      title: 'Email Sent',
                      description: 'A password reset email has been sent. Please check your inbox.',
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        context.push(AppRouter.otpVerificationPath, extra: {'email': email, 'isPasswordReset': true});
                      }
                    });
                  } else {
                    final error = ref.read(authErrorProvider);
                    AppToast.error(context, title: 'Failed to Send Email', description: error ?? 'Please try again');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
