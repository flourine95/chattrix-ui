import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

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
    final errorMessage = useState<String?>(null);
    final successMessage = useState<String?>(null);

    // Auto-hide messages after 5 seconds
    useEffect(() {
      if (errorMessage.value != null || successMessage.value != null) {
        final timer = Timer(const Duration(seconds: 5), () {
          if (context.mounted) {
            errorMessage.value = null;
            successMessage.value = null;
          }
        });
        return timer.cancel; // Proper cleanup
      }
      return null;
    }, [errorMessage.value, successMessage.value]);

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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Tiêu đề
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start your journey with us today',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(height: 40),

                  // Form đăng ký
                  AppInputField(
                    labelText: 'Full Name',
                    controller: fullNameController,
                    useModernStyle: true,
                  ),
                  const SizedBox(height: 20),
                  AppInputField(
                    labelText: 'Username',
                    controller: usernameController,
                    useModernStyle: true,
                  ),
                  const SizedBox(height: 20),
                  AppInputField(
                    labelText: 'Email',
                    controller: emailController,
                    useModernStyle: true,
                  ),
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

                            // Clear previous messages
                            errorMessage.value = null;
                            successMessage.value = null;

                            // Validate
                            if (fullName.isEmpty ||
                                username.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty) {
                              errorMessage.value = 'Please fill in all fields';
                              return;
                            }

                            if (!email.contains('@')) {
                              errorMessage.value = 'Invalid email address';
                              return;
                            }

                            if (password.length < 6) {
                              errorMessage.value = 'Password must be at least 6 characters long';
                              return;
                            }

                            if (password != confirmPassword) {
                              errorMessage.value = 'Passwords do not match';
                              return;
                            }

                            // Call API
                            final success = await ref
                                .read(authNotifierProvider.notifier)
                                .register(username: username, email: email, password: password, fullName: fullName);

                            if (!context.mounted) return;

                            if (success) {
                              successMessage.value = 'Registration successful! Please check your email to verify your account.';
                              // Navigate to OTP verification screen after a short delay
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) {
                                  context.push(AppRouter.otpVerificationPath, extra: {'email': email});
                                }
                              });
                            } else {
                              final error = ref.read(authErrorProvider);
                              errorMessage.value = error ?? 'Registration failed. Please try again.';
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

            // Animated error/success banner at top
            if (errorMessage.value != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedErrorBanner(message: errorMessage.value!),
              ),
            if (successMessage.value != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedSuccessBanner(message: successMessage.value!),
              ),
          ],
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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
            ),
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedErrorBanner extends StatefulWidget {
  final String message;

  const _AnimatedErrorBanner({required this.message});

  @override
  State<_AnimatedErrorBanner> createState() => _AnimatedErrorBannerState();
}

class _AnimatedErrorBannerState extends State<_AnimatedErrorBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedSuccessBanner extends StatefulWidget {
  final String message;

  const _AnimatedSuccessBanner({required this.message});

  @override
  State<_AnimatedSuccessBanner> createState() => _AnimatedSuccessBannerState();
}

class _AnimatedSuccessBannerState extends State<_AnimatedSuccessBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Slide from left
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green.shade600,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
