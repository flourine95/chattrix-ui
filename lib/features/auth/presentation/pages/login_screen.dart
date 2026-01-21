import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = useState<String?>(null);
    final comingSoonMessage = useState<String?>(null);

    // Auto-hide error after 5 seconds
    useEffect(() {
      if (errorMessage.value != null) {
        final timer = Timer(const Duration(seconds: 5), () {
          if (context.mounted && errorMessage.value != null) {
            errorMessage.value = null;
          }
        });
        return timer.cancel; // Proper cleanup
      }
      return null;
    }, [errorMessage.value]);

    // Auto-hide coming soon message after 3 seconds
    useEffect(() {
      if (comingSoonMessage.value != null) {
        final timer = Timer(const Duration(seconds: 3), () {
          if (context.mounted && comingSoonMessage.value != null) {
            comingSoonMessage.value = null;
          }
        });
        return timer.cancel; // Proper cleanup
      }
      return null;
    }, [comingSoonMessage.value]);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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

                  AppInputField(
                    labelText: 'Email or Username',
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
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push(AppRouter.forgotPasswordPath),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
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

                      // Clear previous error
                      errorMessage.value = null;

                      if (email.isEmpty || password.isEmpty) {
                        errorMessage.value = 'Please fill in all fields';
                        return;
                      }

                      final success = await ref
                          .read(authNotifierProvider.notifier)
                          .login(usernameOrEmail: email, password: password);

                      if (!context.mounted) return;

                      if (success) {
                        // No notification on success - just navigate
                        // The router will automatically redirect to home due to the auth guard
                        context.go('/');
                      } else {
                        final error = ref.read(authErrorProvider);

                        // Check if error is about email not verified
                        if (error != null && error.contains('Email not verified')) {
                          errorMessage.value = error;
                          // Navigate to OTP verification screen after a short delay
                          Future.delayed(const Duration(seconds: 2), () {
                            if (context.mounted) {
                              context.push(AppRouter.otpVerificationPath, extra: email);
                            }
                          });
                        } else {
                          errorMessage.value = error ?? 'Invalid credentials. Please try again.';
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
                      comingSoonMessage.value = 'Google login coming soon';
                    },
                  ),
                  const SizedBox(height: 16),
                  SocialLoginButton(
                    icon: FontAwesomeIcons.apple,
                    text: 'Continue with Apple',
                    onPressed: () {
                      comingSoonMessage.value = 'Apple login coming soon';
                    },
                  ),
                  const SizedBox(height: 16),
                  SocialLoginButton(
                    icon: FontAwesomeIcons.facebook,
                    text: 'Continue with Facebook',
                    onPressed: () {
                      comingSoonMessage.value = 'Facebook login coming soon';
                    },
                  ),
                  const SizedBox(height: 40),

                  _buildSignUpLink(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Animated error banner at top
            if (errorMessage.value != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedErrorBanner(message: errorMessage.value!),
              ),
            
            // Animated coming soon banner at top
            if (comingSoonMessage.value != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedInfoBanner(message: comingSoonMessage.value!),
              ),
          ],
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
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
            ),
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

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark 
        ? Colors.grey[700]!.withValues(alpha: 0.5)
        : Colors.grey[300]!.withValues(alpha: 0.8);
    
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
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
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
      ],
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

class _AnimatedInfoBanner extends StatefulWidget {
  final String message;

  const _AnimatedInfoBanner({required this.message});

  @override
  State<_AnimatedInfoBanner> createState() => _AnimatedInfoBannerState();
}

class _AnimatedInfoBannerState extends State<_AnimatedInfoBanner> with SingleTickerProviderStateMixin {
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
          color: Colors.blue.shade600,
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
              const Icon(Icons.info_outline, color: Colors.white, size: 20),
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
