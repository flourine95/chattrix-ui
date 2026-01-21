import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String? email;
  final bool isPasswordReset;

  const OtpVerificationScreen({super.key, this.email, this.isPasswordReset = false});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;
  late final TextEditingController _newPasswordController;
  late String _email;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());
    _newPasswordController = TextEditingController();
    _email = widget.email ?? '';
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _newPasswordController.dispose();
    super.dispose();
  }

  String _getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  Future<void> _verifyOtp() async {
    final otp = _getOtpCode();

    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (otp.length != 6) {
      setState(() => _errorMessage = 'Please enter the full 6-digit OTP');
      return;
    }

    if (_email.isEmpty) {
      setState(() => _errorMessage = 'Invalid email');
      return;
    }

    // If it's a password reset, a new password is required
    if (widget.isPasswordReset) {
      final newPassword = _newPasswordController.text;

      if (newPassword.isEmpty) {
        setState(() => _errorMessage = 'Please enter a new password');
        return;
      }

      if (newPassword.length < 6) {
        setState(() => _errorMessage = 'Password must be at least 6 characters long');
        return;
      }

      // Call reset password API
      final success = await ref
          .read(authNotifierProvider.notifier)
          .resetPassword(email: _email, otp: otp, newPassword: newPassword);

      if (!mounted) return;

      if (success) {
        setState(() => _successMessage = 'Password reset successful! Redirecting to login...');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) context.go(AppRouter.loginPath);
        });
      } else {
        final error = ref.read(authErrorProvider);
        setState(() => _errorMessage = error ?? 'Invalid or expired OTP code');
      }
    } else {
      // Normal email verification flow
      final success = await ref.read(authNotifierProvider.notifier).verifyEmail(email: _email, otp: otp);

      if (!mounted) return;

      if (success) {
        setState(() => _successMessage = 'Email verified successfully! Redirecting to login...');
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) context.go(AppRouter.loginPath);
        });
      } else {
        final error = ref.read(authErrorProvider);
        setState(() => _errorMessage = error ?? 'Invalid OTP code');
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _errorMessage = null;
      _successMessage = null;
    });

    if (_email.isEmpty) {
      setState(() => _errorMessage = 'Invalid email');
      return;
    }

    // If it's a password reset, call forgot password again
    // If it's email verification, call resend verification
    final success = widget.isPasswordReset
        ? await ref.read(authNotifierProvider.notifier).forgotPassword(email: _email)
        : await ref.read(authNotifierProvider.notifier).resendVerification(email: _email);

    if (!mounted) return;

    if (success) {
      setState(() => _successMessage = 'A new OTP has been sent. Please check your email.');
    } else {
      final error = ref.read(authErrorProvider);
      setState(() => _errorMessage = error ?? 'Failed to resend OTP. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Title
                  Text(
                    widget.isPasswordReset ? 'Reset Password' : 'OTP Verification',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isPasswordReset
                        ? 'Enter the 6-digit code sent to\n$_email\nand your new password'
                        : 'Enter the 6-digit code sent to\n$_email',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // OTP Input Fields
                  _buildOtpInputFields(),
                  const SizedBox(height: 30),

                  // If it's a password reset, show the new password field
                  if (widget.isPasswordReset) ...[
                    AppInputField(
                      labelText: 'New Password',
                      isPassword: true,
                      controller: _newPasswordController,
                      useModernStyle: true,
                    ),
                    const SizedBox(height: 30),
                  ],

                  // Verify Button
                  PrimaryButton(
                    text: widget.isPasswordReset ? 'Reset Password' : 'Verify',
                    isLoading: isLoading,
                    onPressed: _verifyOtp,
                  ),
                  const SizedBox(height: 20),

                  // Resend Code Link
                  TextButton(onPressed: isLoading ? null : _resendOtp, child: const Text('Resend Code')),
                ],
              ),
            ),

            // Animated error/success banner at top
            if (_errorMessage != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedErrorBanner(message: _errorMessage!),
              ),
            if (_successMessage != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _AnimatedSuccessBanner(message: _successMessage!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 48,
            height: 52,
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              onChanged: (text) {
                if (text.length == 1 && index < 5) {
                  _focusNodes[index + 1].requestFocus();
                }
                if (text.isEmpty && index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              },
              style: Theme.of(context).textTheme.headlineSmall,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
                ),
              ),
            ),
          );
        }),
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
