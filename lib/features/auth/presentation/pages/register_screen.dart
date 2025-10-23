import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullNameController = useTextEditingController();
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final agreedToTerms = useState(false);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => context.go(AppRouter.loginPath),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Tiêu đề
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start your journey with us today',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 40),

              // Form đăng ký
              AppInputField(
                labelText: 'Full Name',
                controller: fullNameController,
              ),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Username',
                controller: usernameController,
              ),
              const SizedBox(height: 20),
              AppInputField(labelText: 'Email', controller: emailController),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Password',
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Confirm Password',
                isPassword: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 20),

              // Checkbox điều khoản
              _buildTermsCheckbox(context, agreedToTerms),
              const SizedBox(height: 30),

              // Nút đăng ký
              PrimaryButton(
                text: 'Register',
                isLoading: isLoading,
                onPressed: agreedToTerms.value
                    ? () async {
                        final fullName = fullNameController.text.trim();
                        final username = usernameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passwordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        // Validate
                        if (fullName.isEmpty ||
                            username.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          Toasts.error(
                            context,
                            title: 'Error',
                            description: 'Please fill in all fields',
                          );
                          return;
                        }

                        if (!email.contains('@')) {
                          Toasts.error(
                            context,
                            title: 'Error',
                            description: 'Invalid email address',
                          );
                          return;
                        }

                        if (password.length < 6) {
                          Toasts.error(
                            context,
                            title: 'Error',
                            description:
                                'Password must be at least 6 characters long',
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          Toasts.error(
                            context,
                            title: 'Error',
                            description: 'Passwords do not match',
                          );
                          return;
                        }

                        // Call API
                        final success = await ref
                            .read(authNotifierProvider.notifier)
                            .register(
                              username: username,
                              email: email,
                              password: password,
                              fullName: fullName,
                            );

                        if (!context.mounted) return;

                        if (success) {
                          Toasts.success(
                            context,
                            title: 'Success',
                            description:
                                'Registration successful! Please check your email to verify your account.',
                          );
                          // Navigate to OTP verification screen
                          context.push(
                            AppRouter.otpVerificationPath,
                            extra: {'email': email},
                          );
                        } else {
                          final error = ref.read(authErrorProvider);
                          Toasts.error(
                            context,
                            title: 'Registration Failed',
                            description: error ?? 'An error occurred',
                          );
                        }
                      }
                    : null,
              ),
              const SizedBox(height: 40),

              // Link đăng nhập
              _buildLoginLink(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox(
    BuildContext context,
    ValueNotifier<bool> agreedToTerms,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: agreedToTerms.value,
            onChanged: (bool? value) {
              agreedToTerms.value = value ?? false;
            },
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  // recognizer: TapGestureRecognizer()..onTap = () { /* Mở link điều khoản */ },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        TextButton(
          onPressed: () => context.go(AppRouter.loginPath),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Text('Login'),
        ),
      ],
    );
  }
}
