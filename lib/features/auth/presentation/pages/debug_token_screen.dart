import 'dart:async';

import 'package:chattrix_ui/core/toast/toast_controller.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Screen để debug và test auto-refresh token
class DebugTokenScreen extends ConsumerStatefulWidget {
  const DebugTokenScreen({super.key});

  @override
  ConsumerState<DebugTokenScreen> createState() => _DebugTokenScreenState();
}

class _DebugTokenScreenState extends ConsumerState<DebugTokenScreen> {
  final _storage = const FlutterSecureStorage();
  String? _accessToken;
  String? _refreshToken;
  bool _isLoading = false;

  // Countdown timer
  Timer? _countdownTimer;
  int _accessTokenSecondsLeft = 30;
  int _refreshTokenSecondsLeft = 120;
  bool _isTimerRunning = false;

  // Auto-refresh timer to update token display
  Timer? _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    _loadTokens();
    // Auto reload tokens every 2 seconds to see changes
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _loadTokens();
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadTokens() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (mounted) {
      setState(() {
        _accessToken = accessToken;
        _refreshToken = refreshToken;
      });
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _accessTokenSecondsLeft = 30;
      _refreshTokenSecondsLeft = 120;
      _isTimerRunning = true;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (_accessTokenSecondsLeft > 0) {
          _accessTokenSecondsLeft--;
        }
        if (_refreshTokenSecondsLeft > 0) {
          _refreshTokenSecondsLeft--;
        }

        if (_refreshTokenSecondsLeft == 0) {
          _countdownTimer?.cancel();
          _isTimerRunning = false;
        }
      });
    });
  }

  void _stopCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

  Future<void> _testGetCurrentUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ref.read(getCurrentUserUseCaseProvider)();

      result.fold(
        (failure) {
          setState(() {
            _isLoading = false;
          });
          Toasts.error(
            context,
            title: 'API Failed',
            description: failure.toString(),
          );
        },
        (user) {
          setState(() {
            _isLoading = false;
          });
          Toasts.success(
            context,
            title: 'Success',
            description: 'Token refreshed & user loaded',
          );
        },
      );

      // Reload tokens immediately to see the new ones
      await _loadTokens();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Toasts.error(context, title: 'Error', description: e.toString());
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Color _getTimerColor(int seconds, int total) {
    final percentage = seconds / total;
    if (percentage > 0.5) return Colors.green;
    if (percentage > 0.2) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Monitor'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTokens,
            tooltip: 'Reload Tokens',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isTimerRunning ? null : _startCountdown,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isTimerRunning ? _stopCountdown : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Stop'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Access Token
            _buildTokenCard(
              'Access Token',
              _accessToken,
              _accessTokenSecondsLeft,
              30,
              Colors.blue,
            ),

            const SizedBox(height: 16),

            // Refresh Token
            _buildTokenCard(
              'Refresh Token',
              _refreshToken,
              _refreshTokenSecondsLeft,
              120,
              Colors.purple,
            ),

            const SizedBox(height: 24),

            // Test API Button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _testGetCurrentUser,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.api),
              label: const Text('Test API (Get Current User)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 16),

            // Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tokens tự động cập nhật mỗi 2 giây',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenCard(
    String label,
    String? token,
    int seconds,
    int total,
    Color color,
  ) {
    final percentage = seconds / total;
    final timerColor = _getTimerColor(seconds, total);
    final tokenPreview = token != null && token.length > 60
        ? '${token.substring(0, 30)}...${token.substring(token.length - 30)}'
        : token ?? 'No token';

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color,
                  ),
                ),
                if (_isTimerRunning)
                  Text(
                    _formatTime(seconds),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: timerColor,
                    ),
                  ),
              ],
            ),

            // Timer Progress Bar
            if (_isTimerRunning) ...[
              const SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: timerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 12),

            // Token Value
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SelectableText(
                tokenPreview,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
              ),
            ),

            // Copy Button
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: token != null
                    ? () {
                        Clipboard.setData(ClipboardData(text: token));
                        Toasts.success(
                          context,
                          title: 'Copied',
                          description: '$label copied to clipboard',
                        );
                      }
                    : null,
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copy', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
