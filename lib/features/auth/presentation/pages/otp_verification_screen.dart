import 'package:chattrix_ui/core/router/app_router.dart';
import 'package:chattrix_ui/core/toast/toastification_helper.dart';
import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpVerificationScreen extends HookConsumerWidget {
  final String? email;
  final bool isPasswordReset;

  const OtpVerificationScreen({super.key, this.email, this.isPasswordReset = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNodes = useMemoized(() => List.generate(6, (_) => FocusNode()), []);
    final controllers = useMemoized(() => List.generate(6, (_) => TextEditingController()), []);
    final newPasswordController = useTextEditingController();
    final emailValue = useState(email ?? '');
    final isLoading = ref.watch(isLoadingProvider);

    useEffect(() {
      return () {
        for (var node in focusNodes) {
          node.dispose();
        }
        for (var controller in controllers) {
          controller.dispose();
        }
      };
    }, []);

    String getOtpCode() {
      return controllers.map((c) => c.text).join();
    }

    Future<void> verifyOtp() async {
      final otp = getOtpCode();

      if (otp.length != 6) {
        AppToast.warning(context, title: 'Incomplete OTP', description: 'Please enter the full 6-digit OTP');
        return;
      }

      if (emailValue.value.isEmpty) {
        AppToast.error(context, title: 'Invalid Email', description: 'Email address is missing');
        return;
      }

      if (isPasswordReset) {
        final newPassword = newPasswordController.text;

        if (newPassword.isEmpty) {
          AppToast.warning(context, title: 'Password Required', description: 'Please enter a new password');
          return;
        }

        if (newPassword.length < 6) {
          AppToast.warning(context, title: 'Weak Password', description: 'Password must be at least 6 characters long');
          return;
        }

        final success = await ref
            .read(authProvider.notifier)
            .resetPassword(email: emailValue.value, otp: otp, newPassword: newPassword);

        if (!context.mounted) return;

        if (success) {
          AppToast.success(context, title: 'Password Reset Successful!', description: 'Redirecting to login...');
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) context.go(AppRouter.loginPath);
          });
        } else {
          final error = ref.read(authErrorProvider);
          AppToast.error(context, title: 'Reset Failed', description: error ?? 'Invalid or expired OTP code');
        }
      } else {
        final success = await ref.read(authProvider.notifier).verifyEmail(email: emailValue.value, otp: otp);

        if (!context.mounted) return;

        if (success) {
          AppToast.success(context, title: 'Email Verified!', description: 'Redirecting to login...');
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) context.go(AppRouter.loginPath);
          });
        } else {
          final error = ref.read(authErrorProvider);
          AppToast.error(context, title: 'Verification Failed', description: error ?? 'Invalid OTP code');
        }
      }
    }

    Future<void> resendOtp() async {
      if (emailValue.value.isEmpty) {
        AppToast.error(context, title: 'Invalid Email', description: 'Email address is missing');
        return;
      }

      final success = isPasswordReset
          ? await ref.read(authProvider.notifier).forgotPassword(email: emailValue.value)
          : await ref.read(authProvider.notifier).resendVerification(email: emailValue.value);

      if (!context.mounted) return;

      if (success) {
        AppToast.success(
          context,
          title: 'OTP Resent',
          description: 'A new OTP has been sent. Please check your email.',
        );
      } else {
        final error = ref.read(authErrorProvider);
        AppToast.error(context, title: 'Resend Failed', description: error ?? 'Please try again');
      }
    }

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
              Text(
                isPasswordReset ? 'Reset Password' : 'OTP Verification',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isPasswordReset
                    ? 'Enter the 6-digit code sent to\n${emailValue.value}\nand your new password'
                    : 'Enter the 6-digit code sent to\n${emailValue.value}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              _buildOtpInputFields(context, controllers, focusNodes),
              const SizedBox(height: 30),

              if (isPasswordReset) ...[
                AppInputField(
                  labelText: 'New Password',
                  isPassword: true,
                  controller: newPasswordController,
                  useModernStyle: true,
                ),
                const SizedBox(height: 30),
              ],

              PrimaryButton(
                text: isPasswordReset ? 'Reset Password' : 'Verify',
                isLoading: isLoading,
                onPressed: verifyOtp,
              ),
              const SizedBox(height: 20),

              TextButton(onPressed: isLoading ? null : resendOtp, child: const Text('Resend Code')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputFields(
    BuildContext context,
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
  ) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 48,
            height: 52,
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              onChanged: (text) {
                if (text.length == 1 && index < 5) {
                  focusNodes[index + 1].requestFocus();
                }
                if (text.isEmpty && index > 0) {
                  focusNodes[index - 1].requestFocus();
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
