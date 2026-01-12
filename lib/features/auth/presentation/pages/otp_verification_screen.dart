import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toast_controller.dart';
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

    if (otp.length != 6) {
      Toasts.error(context, title: 'Error', description: 'Please enter the full 6-digit OTP');
      return;
    }

    if (_email.isEmpty) {
      Toasts.error(context, title: 'Error', description: 'Invalid email');
      return;
    }

    // If it's a password reset, a new password is required
    if (widget.isPasswordReset) {
      final newPassword = _newPasswordController.text;

      if (newPassword.isEmpty) {
        Toasts.error(context, title: 'Error', description: 'Please enter a new password');
        return;
      }

      if (newPassword.length < 6) {
        Toasts.error(context, title: 'Error', description: 'Password must be at least 6 characters long');
        return;
      }

      // Call reset password API
      final success = await ref
          .read(authNotifierProvider.notifier)
          .resetPassword(email: _email, otp: otp, newPassword: newPassword);

      if (!mounted) return;

      if (success) {
        Toasts.success(context, title: 'Success', description: 'Password reset successful! Please log in.');
        context.go(AppRouter.loginPath);
      } else {
        final error = ref.read(authErrorProvider);
        Toasts.error(context, title: 'Password Reset Failed', description: error ?? 'Invalid or expired OTP code');
      }
    } else {
      // Normal email verification flow
      final success = await ref.read(authNotifierProvider.notifier).verifyEmail(email: _email, otp: otp);

      if (!mounted) return;

      if (success) {
        Toasts.success(context, title: 'Success', description: 'Email verified successfully! Please log in.');
        context.go(AppRouter.loginPath);
      } else {
        final error = ref.read(authErrorProvider);
        Toasts.error(context, title: 'Verification Failed', description: error ?? 'Invalid OTP code');
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_email.isEmpty) {
      Toasts.error(context, title: 'Error', description: 'Invalid email');
      return;
    }

    // If it's a password reset, call forgot password again
    // If it's email verification, call resend verification
    final success = widget.isPasswordReset
        ? await ref.read(authNotifierProvider.notifier).forgotPassword(email: _email)
        : await ref.read(authNotifierProvider.notifier).resendVerification(email: _email);

    if (!mounted) return;

    if (success) {
      Toasts.success(context, title: 'Success', description: 'A new OTP has been sent. Please check your email.');
    } else {
      final error = ref.read(authErrorProvider);
      Toasts.error(context, title: 'Resend Failed', description: error ?? 'An error occurred');
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
        child: SingleChildScrollView(
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
                AppInputField(labelText: 'New Password', isPassword: true, controller: _newPasswordController),
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
