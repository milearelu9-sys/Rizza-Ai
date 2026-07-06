import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import '../widgets/result_card.dart';
import '../services/history_service.dart';

class ResultScreen extends StatefulWidget {
  final String roastResponse;
  final String rizzResponse;
  final String inputText;
  final String mode;

  const ResultScreen({
    Key? key,
    required this.roastResponse,
    required this.rizzResponse,
    required this.inputText,
    required this.mode,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveToHistory();
  }

  Future<void> _saveToHistory() async {
    final entry = HistoryEntry(
      id: const Uuid().v4(),
      inputText: widget.inputText,
      roastResponse: widget.roastResponse,
      rizzResponse: widget.rizzResponse,
      createdAt: DateTime.now(),
      mode: widget.mode,
    );
    await HistoryService.saveEntry(entry);
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isModeRoast = widget.mode == 'roast';
    final displayText = isModeRoast ? widget.roastResponse : widget.rizzResponse;
    final accentColor = isModeRoast ? const Color(0xFFFF006E) : const Color(0xFF8338EC);
    final modeEmoji = isModeRoast ? '🔥' : '💘';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Input:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1F3A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[800]!,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.inputText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ResultCard(
                      emoji: modeEmoji,
                      title: isModeRoast ? 'Your Roast' : 'Your Rizz Boost',
                      content: displayText,
                      accentColor: accentColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _ActionButtonSmall(
                    label: 'Copy',
                    icon: Icons.copy,
                    onPressed: () => _copyToClipboard(displayText),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButtonSmall(
                    label: 'Share',
                    icon: Icons.share,
                    onPressed: () {
                      Share.share(displayText);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Try Another',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtonSmall extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButtonSmall({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A1F3A),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[700]!),
        ),
      ),
    );
  }
}
