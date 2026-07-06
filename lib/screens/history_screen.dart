import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../services/history_service.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<HistoryEntry>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = HistoryService.getHistory();
  }

  void _refreshHistory() {
    setState(() {
      _historyFuture = HistoryService.getHistory();
    });
  }

  void _deleteEntry(String id) async {
    await HistoryService.deleteEntry(id);
    _refreshHistory();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted from history')),
    );
  }

  void _clearAllHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History?'),
        content: const Text('This will delete all saved responses. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await HistoryService.clearHistory();
              _refreshHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Color(0xFFFF006E))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearAllHistory,
          ),
        ],
      ),
      body: FutureBuilder<List<HistoryEntry>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No history yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your generated responses will appear here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          final history = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final entry = history[index];
              final isModeRoast = entry.mode == 'roast';
              final displayText = isModeRoast ? entry.roastResponse : entry.rizzResponse;
              final accentColor = isModeRoast ? const Color(0xFFFF006E) : const Color(0xFF8338EC);
              final modeEmoji = isModeRoast ? '🔥' : '💘';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F3A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(modeEmoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Text(
                                isModeRoast ? 'Roast' : 'Rizz',
                                style: TextStyle(
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            DateFormat('dd/MM/yy').format(entry.createdAt),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '"${entry.inputText.length > 100 ? entry.inputText.substring(0, 100) + '...' : entry.inputText}"',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[400],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        displayText.length > 150
                            ? displayText.substring(0, 150) + '...'
                            : displayText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => Share.share(displayText),
                            icon: const Icon(Icons.share, size: 18),
                            label: const Text('Share'),
                            style: TextButton.styleFrom(
                              foregroundColor: accentColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () => _deleteEntry(entry.id),
                            icon: const Icon(Icons.delete, size: 18),
                            label: const Text('Delete'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
