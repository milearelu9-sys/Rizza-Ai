import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryEntry {
  final String id;
  final String inputText;
  final String roastResponse;
  final String rizzResponse;
  final DateTime createdAt;
  final String mode;

  HistoryEntry({
    required this.id,
    required this.inputText,
    required this.roastResponse,
    required this.rizzResponse,
    required this.createdAt,
    required this.mode,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'inputText': inputText,
    'roastResponse': roastResponse,
    'rizzResponse': rizzResponse,
    'createdAt': createdAt.toIso8601String(),
    'mode': mode,
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json['id'] as String,
    inputText: json['inputText'] as String,
    roastResponse: json['roastResponse'] as String,
    rizzResponse: json['rizzResponse'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    mode: json['mode'] as String,
  );
}

class HistoryService {
  static const String _historyKey = 'rizzai_history';
  static const int _maxHistoryItems = 100;

  /// Save a new history entry
  static Future<void> saveEntry(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    
    List<HistoryEntry> history = [];
    if (historyJson != null) {
      final decoded = jsonDecode(historyJson) as List;
      history = decoded.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
    }

    // Add new entry at the beginning
    history.insert(0, entry);

    // Keep only last 100 entries
    if (history.length > _maxHistoryItems) {
      history = history.sublist(0, _maxHistoryItems);
    }

    final encoded = jsonEncode(history.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, encoded);
  }

  /// Get all history entries
  static Future<List<HistoryEntry>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    
    if (historyJson == null) return [];
    
    final decoded = jsonDecode(historyJson) as List;
    return decoded.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Delete a history entry
  static Future<void> deleteEntry(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.removeWhere((e) => e.id == id);
    
    final encoded = jsonEncode(history.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, encoded);
  }

  /// Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
