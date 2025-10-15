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

  const OtpVerificationScreen({
    super.key,
    this.email,
    this.isPasswordReset = false,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
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
      Toasts.error(
        context,
        title: 'Lỗi',
        description: 'Vui lòng nhập đầy đủ 6 số OTP',
      );
      return;
    }

    if (_email.isEmpty) {
      Toasts.error(context, title: 'Lỗi', description: 'Email không hợp lệ');
      return;
    }

    // Nếu là reset password, cần nhập mật khẩu mới
    if (widget.isPasswordReset) {
      final newPassword = _newPasswordController.text;

      if (newPassword.isEmpty) {
        Toasts.error(
          context,
          title: 'Lỗi',
          description: 'Vui lòng nhập mật khẩu mới',
        );
        return;
      }

      if (newPassword.length < 6) {
        Toasts.error(
          context,
          title: 'Lỗi',
          description: 'Mật khẩu phải có ít nhất 6 ký tự',
        );
        return;
      }

      // Call reset password API
      final success = await ref
          .read(authNotifierProvider.notifier)
          .resetPassword(email: _email, otp: otp, newPassword: newPassword);

      if (!mounted) return;

      if (success) {
        Toasts.success(
          context,
          title: 'Thành công',
          description: 'Đặt lại mật khẩu thành công! Vui lòng đăng nhập.',
        );
        context.go(AppRouter.loginPath);
      } else {
        final error = ref.read(authErrorProvider);
        Toasts.error(
          context,
          title: 'Đặt lại mật khẩu thất bại',
          description: error ?? 'Mã OTP không đúng hoặc đã hết hạn',
        );
      }
    } else {
      // Flow verify email bình thường
      final success = await ref
          .read(authNotifierProvider.notifier)
          .verifyEmail(email: _email, otp: otp);

      if (!mounted) return;

      if (success) {
        Toasts.success(
          context,
          title: 'Thành công',
          description: 'Xác thực email thành công! Vui lòng đăng nhập.',
        );
        context.go(AppRouter.loginPath);
      } else {
        final error = ref.read(authErrorProvider);
        Toasts.error(
          context,
          title: 'Xác thực thất bại',
          description: error ?? 'Mã OTP không đúng',
        );
      }
    }
  }

  Future<void> _resendOtp() async {
    if (_email.isEmpty) {
      Toasts.error(context, title: 'Lỗi', description: 'Email không hợp lệ');
      return;
    }

    // Nếu là reset password thì gọi forgot password lại
    // Nếu là verify email thì gọi resend verification
    final success = widget.isPasswordReset
        ? await ref
              .read(authNotifierProvider.notifier)
              .forgotPassword(email: _email)
        : await ref
              .read(authNotifierProvider.notifier)
              .resendVerification(email: _email);

    if (!mounted) return;

    if (success) {
      Toasts.success(
        context,
        title: 'Thành công',
        description: 'Đã gửi lại mã OTP. Vui lòng kiểm tra email.',
      );
    } else {
      final error = ref.read(authErrorProvider);
      Toasts.error(
        context,
        title: 'Gửi lại thất bại',
        description: error ?? 'Có lỗi xảy ra',
      );
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Tiêu đề
              Text(
                widget.isPasswordReset ? 'Reset Password' : 'OTP Verification',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.isPasswordReset
                    ? 'Enter the 6-digit code sent to\n$_email\nand your new password'
                    : 'Enter the 6-digit code sent to\n$_email',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Các ô nhập OTP
              _buildOtpInputFields(),
              const SizedBox(height: 30),

              // Nếu là reset password, hiển thị field nhập mật khẩu mới
              if (widget.isPasswordReset) ...[
                AppInputField(
                  labelText: 'New Password',
                  isPassword: true,
                  controller: _newPasswordController,
                ),
                const SizedBox(height: 30),
              ],

              // Nút xác thực
              PrimaryButton(
                text: widget.isPasswordReset ? 'Reset Password' : 'Verify',
                isLoading: isLoading,
                onPressed: _verifyOtp,
              ),
              const SizedBox(height: 20),

              // Link gửi lại code
              TextButton(
                onPressed: isLoading ? null : _resendOtp,
                child: const Text('Resend Code'),
              ),
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
