import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  // Tiêu đề
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

                  // Input email
                  AppInputField(
                    labelText: 'Email',
                    controller: emailController,
                    useModernStyle: true,
                  ),
                  const SizedBox(height: 30),

                  // Nút gửi link
                  PrimaryButton(
                    text: 'Send Reset Link',
                    isLoading: isLoading,
                    onPressed: () async {
                      final email = emailController.text.trim();

                      // Clear previous messages
                      errorMessage.value = null;
                      successMessage.value = null;

                      // Validate email
                      if (email.isEmpty) {
                        errorMessage.value = 'Please enter your email';
                        return;
                      }

                      if (!email.contains('@')) {
                        errorMessage.value = 'Invalid email address';
                        return;
                      }

                      // Call API
                      final success = await ref.read(authNotifierProvider.notifier).forgotPassword(email: email);

                      if (!context.mounted) return;

                      if (success) {
                        successMessage.value = 'A password reset email has been sent. Please check your inbox.';
                        // Navigate to OTP screen for password reset after a short delay
                        Future.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            context.push(AppRouter.otpVerificationPath, extra: {'email': email, 'isPasswordReset': true});
                          }
                        });
                      } else {
                        final error = ref.read(authErrorProvider);
                        errorMessage.value = error ?? 'Failed to send reset email. Please try again.';
                      }
                    },
                  ),
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
