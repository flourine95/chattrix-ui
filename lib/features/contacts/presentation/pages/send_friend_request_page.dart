import 'package:chattrix_ui/core/widgets/app_input_field.dart';
import 'package:chattrix_ui/core/widgets/primary_button.dart';
import 'package:chattrix_ui/features/contacts/presentation/providers/contact_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendFriendRequestPage extends ConsumerStatefulWidget {
  const SendFriendRequestPage({super.key});

  @override
  ConsumerState<SendFriendRequestPage> createState() => _SendFriendRequestPageState();
}

class _SendFriendRequestPageState extends ConsumerState<SendFriendRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _sendFriendRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final receiverUserId = int.tryParse(_userIdController.text);
    if (receiverUserId == null) {
      setState(() => _isLoading = false);
      messenger.showSnackBar(const SnackBar(content: Text('Invalid user ID')));
      return;
    }

    final success = await ref
        .read(contactProvider.notifier)
        .sendFriendRequest(
          receiverUserId: receiverUserId,
          nickname: _nicknameController.text.isEmpty ? null : _nicknameController.text,
        );

    setState(() => _isLoading = false);

    if (success) {
      messenger.showSnackBar(const SnackBar(content: Text('Friend request sent successfully')));
      navigator.pop();
    } else {
      final errorMessage = ref.read(contactProvider).errorMessage ?? 'Failed to send request';
      messenger.showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Add Friend', style: textTheme.titleLarge)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Enter the user ID of the person you want to add as a friend', style: textTheme.bodyMedium),
              const SizedBox(height: 24),
              AppInputField(
                controller: _userIdController,
                labelText: 'User ID',
                hintText: 'Enter user ID (e.g., 2)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _nicknameController,
                labelText: 'Nickname (Optional)',
                hintText: 'Enter a nickname for this contact',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: _isLoading ? null : _sendFriendRequest,
                text: 'Send Friend Request',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
