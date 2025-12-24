import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// iOS-style date range picker for media filter
class MediaDateFilterBottomSheet extends StatefulWidget {
  const MediaDateFilterBottomSheet({super.key});

  @override
  State<MediaDateFilterBottomSheet> createState() => _MediaDateFilterBottomSheetState();
}

class _MediaDateFilterBottomSheetState extends State<MediaDateFilterBottomSheet> {
  String _selectedFilter = 'All';
  DateTime? _customStartDate;
  DateTime? _customEndDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Filter Media by Date',
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            // Quick filters
            _buildQuickFilter('All', colors, textTheme),
            _buildQuickFilter('Today', colors, textTheme),
            _buildQuickFilter('This Week', colors, textTheme),
            _buildQuickFilter('This Month', colors, textTheme),
            _buildQuickFilter('This Year', colors, textTheme),
            
            Divider(height: 1, color: colors.outlineVariant),

            // Custom date range
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _selectedFilter == 'Custom' 
                      ? colors.primaryContainer 
                      : colors.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.date_range,
                  color: _selectedFilter == 'Custom' 
                      ? colors.onPrimaryContainer 
                      : colors.onSurface,
                  size: 22,
                ),
              ),
              title: Text(
                'Custom Range',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: _selectedFilter == 'Custom' ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              subtitle: _customStartDate != null && _customEndDate != null
                  ? Text('${_formatDate(_customStartDate!)} - ${_formatDate(_customEndDate!)}')
                  : null,
              trailing: _selectedFilter == 'Custom' 
                  ? Icon(Icons.check_circle, color: colors.primary)
                  : null,
              onTap: () => _showCustomDatePicker(context, colors, textTheme),
            ),

            const SizedBox(height: 16),

            // Apply button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, {
                    'filter': _selectedFilter,
                    'startDate': _customStartDate,
                    'endDate': _customEndDate,
                  }),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Apply Filter', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilter(String label, ColorScheme colors, TextTheme textTheme) {
    final isSelected = _selectedFilter == label;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryContainer : colors.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getIconForFilter(label),
          color: isSelected ? colors.onPrimaryContainer : colors.onSurface,
          size: 22,
        ),
      ),
      title: Text(
        label,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? Icon(Icons.check_circle, color: colors.primary) : null,
      onTap: () => setState(() => _selectedFilter = label),
    );
  }

  IconData _getIconForFilter(String filter) {
    switch (filter) {
      case 'All': return Icons.all_inclusive;
      case 'Today': return Icons.today;
      case 'This Week': return Icons.view_week;
      case 'This Month': return Icons.calendar_month;
      case 'This Year': return Icons.calendar_today;
      default: return Icons.filter_list;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCustomDatePicker(BuildContext context, ColorScheme colors, TextTheme textTheme) async {
    final now = DateTime.now();

    // Show start date picker
    final startDate = await showDatePicker(
      context: context,
      initialDate: _customStartDate ?? now.subtract(const Duration(days: 30)),
      firstDate: DateTime(2020),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colors,
          ),
          child: child!,
        );
      },
    );

    if (startDate == null || !mounted) return;

    // Show end date picker
    final endDate = await showDatePicker(
      context: context,
      initialDate: _customEndDate ?? now,
      firstDate: startDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: colors,
          ),
          child: child!,
        );
      },
    );

    if (endDate == null || !mounted) return;

    setState(() {
      _selectedFilter = 'Custom';
      _customStartDate = startDate;
      _customEndDate = endDate;
    });
  }

}

/// Show the media date filter bottom sheet
Future<Map<String, dynamic>?> showMediaDateFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const MediaDateFilterBottomSheet(),
  );
}

