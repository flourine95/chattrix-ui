import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
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
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
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
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Start your journey with us today',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
              ),
              const SizedBox(height: 40),

              AppInputField(labelText: 'Full Name', controller: fullNameController, useModernStyle: true),
              const SizedBox(height: 20),
              AppInputField(labelText: 'Username', controller: usernameController, useModernStyle: true),
              const SizedBox(height: 20),
              AppInputField(labelText: 'Email', controller: emailController, useModernStyle: true),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Password',
                isPassword: true,
                controller: passwordController,
                useModernStyle: true,
              ),
              const SizedBox(height: 20),
              AppInputField(
                labelText: 'Confirm Password',
                isPassword: true,
                controller: confirmPasswordController,
                useModernStyle: true,
              ),
              const SizedBox(height: 20),

              _buildTermsCheckbox(context, agreedToTerms),
              const SizedBox(height: 30),

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

                        if (fullName.isEmpty ||
                            username.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          AppToast.warning(context, title: 'Missing Fields', description: 'Please fill in all fields');
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

                        if (password.length < 6) {
                          AppToast.warning(
                            context,
                            title: 'Weak Password',
                            description: 'Password must be at least 6 characters long',
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          AppToast.error(context, title: 'Password Mismatch', description: 'Passwords do not match');
                          return;
                        }

                        final success = await ref
                            .read(authProvider.notifier)
                            .register(username: username, email: email, password: password, fullName: fullName);

                        if (!context.mounted) return;

                        if (success) {
                          AppToast.success(
                            context,
                            title: 'Account Created!',
                            description: 'Please check your email to verify your account',
                            autoCloseDuration: const Duration(seconds: 5),
                          );
                          Future.delayed(const Duration(seconds: 2), () {
                            if (context.mounted) {
                              context.push(AppRouter.otpVerificationPath, extra: {'email': email});
                            }
                          });
                        } else {
                          final error = ref.read(authErrorProvider);
                          AppToast.error(
                            context,
                            title: 'Registration Failed',
                            description: error ?? 'Please try again',
                          );
                        }
                      }
                    : null,
              ),
              const SizedBox(height: 40),

              _buildLoginLink(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox(BuildContext context, ValueNotifier<bool> agreedToTerms) {
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
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 14),
          ),
          TextButton(
            onPressed: () => context.go(AppRouter.loginPath),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
