import 'package:chattrix_ui/features/invite_links/domain/entities/invite_link_entity.dart';
import 'package:chattrix_ui/features/invite_links/presentation/providers/create_invite_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CreateInviteLinkBottomSheet extends HookConsumerWidget {
  const CreateInviteLinkBottomSheet({super.key, required this.conversationId, this.onCreated});

  final int conversationId;
  final void Function(InviteLinkEntity)? onCreated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final expiryTime = useState<DateTime?>(null);
    final maxUses = useState<int?>(null);
    final maxUsesController = useTextEditingController();

    final createState = ref.watch(createInviteLinkProvider);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.add_link, color: colors.primary),
                const SizedBox(width: 12),
                Text('Create New Invite Link', style: textTheme.titleLarge),
              ],
            ),

            const SizedBox(height: 24),

            _buildSection(
              context,
              icon: Icons.access_time,
              title: 'Expiration Time',
              subtitle: expiryTime.value != null
                  ? DateFormat('dd/MM/yyyy HH:mm').format(expiryTime.value!)
                  : 'Unlimited',
              onTap: () => _selectExpiryTime(context, expiryTime),
              trailing: expiryTime.value != null
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: () => expiryTime.value = null)
                  : null,
            ),

            const SizedBox(height: 16),

            _buildSection(
              context,
              icon: Icons.people_outline,
              title: 'Maximum Uses',
              subtitle: maxUses.value != null ? '${maxUses.value} uses' : 'Unlimited',
              onTap: () => _selectMaxUses(context, maxUses, maxUsesController),
              trailing: maxUses.value != null
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        maxUses.value = null;
                        maxUsesController.clear();
                      },
                    )
                  : null,
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: createState.isLoading
                  ? null
                  : () => _createLink(context, ref, expiryTime.value, maxUses.value),
              child: createState.isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Create Link'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.bodyMedium),
                  Text(subtitle, style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
                ],
              ),
            ),
            if (trailing != null) trailing else const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  void _selectExpiryTime(BuildContext context, ValueNotifier<DateTime?> expiryTime) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _ExpiryTimePickerBottomSheet(
        onSelected: (time) {
          expiryTime.value = time;
          Navigator.pop(context);
        },
      ),
    );
  }

  void _selectMaxUses(BuildContext context, ValueNotifier<int?> maxUses, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Maximum Uses'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter number (leave empty for unlimited)',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                maxUses.value = value;
              } else {
                maxUses.value = null;
              }
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> _createLink(BuildContext context, WidgetRef ref, DateTime? expiryTime, int? maxUses) async {
    int? expiresIn;
    if (expiryTime != null) {
      final now = DateTime.now();
      expiresIn = expiryTime.difference(now).inSeconds;

      if (expiresIn <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Expiration time must be in the future')));
        return;
      }
    }

    final notifier = ref.read(createInviteLinkProvider.notifier);

    await notifier.create(conversationId: conversationId, expiresIn: expiresIn, maxUses: maxUses);

    final state = ref.read(createInviteLinkProvider);

    if (!context.mounted) return;

    state.when(
      data: (link) {
        if (link != null) {
          onCreated?.call(link);
          Navigator.pop(context);
        }
      },
      loading: () {},
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
      },
    );
  }
}

class _ExpiryTimePickerBottomSheet extends StatelessWidget {
  const _ExpiryTimePickerBottomSheet({required this.onSelected});

  final void Function(DateTime) onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Select Expiration Time', style: textTheme.titleMedium),
          const SizedBox(height: 16),
          _buildQuickOption(context, '1 hour', const Duration(hours: 1)),
          _buildQuickOption(context, '1 day', const Duration(days: 1)),
          _buildQuickOption(context, '7 days', const Duration(days: 7)),
          _buildQuickOption(context, '30 days', const Duration(days: 30)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _selectCustomTime(context),
            icon: const Icon(Icons.calendar_today),
            label: const Text('Select Custom Time'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOption(BuildContext context, String label, Duration duration) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        final time = DateTime.now().add(duration);
        onSelected(time);
      },
    );
  }

  void _selectCustomTime(BuildContext context) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (date == null || !context.mounted) return;

    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time == null || !context.mounted) return;

    final selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

    onSelected(selectedDateTime);
  }
}
