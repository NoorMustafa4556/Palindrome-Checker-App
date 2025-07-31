import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Yeh class aapke purane PalindromeEntry jaisi hai,
// lekin is mein humne toJson aur fromJson methods add kiye hain.
class PalindromeEntry {
  final String input;
  final bool isPalindrome;
  final DateTime timestamp;

  PalindromeEntry({
    required this.input,
    required this.isPalindrome,
    required this.timestamp,
  });

  // Entry ko Map (JSON jaisa) mein convert karne ke liye
  Map<String, dynamic> toJson() => {
    'input': input,
    'isPalindrome': isPalindrome,
    'timestamp': timestamp.toIso8601String(), // DateTime ko String banayein
  };

  // Map se wapis PalindromeEntry object banane ke liye
  factory PalindromeEntry.fromJson(Map<String, dynamic> json) => PalindromeEntry(
    input: json['input'],
    isPalindrome: json['isPalindrome'],
    timestamp: DateTime.parse(json['timestamp']), // String se wapis DateTime banayein
  );
}


// Yeh hamara naya Provider hai
class HistoryProvider with ChangeNotifier {
  List<PalindromeEntry> _history = [];
  static const _historyKey = 'palindrome_history'; // Key for storage

  List<PalindromeEntry> get history => _history;

  HistoryProvider() {
    // Provider bante hi purani history load kar lein
    loadHistory();
  }

  // Nayi entry add karna
  Future<void> addEntry(PalindromeEntry entry) async {
    _history.insert(0, entry); // Nayi entry sab se upar dikhayein
    await _saveHistory(); // History save karein
    notifyListeners(); // UI ko update karein
  }

  // Poori history clear karna
  Future<void> clearHistory() async {
    _history.clear();
    await _saveHistory();
    notifyListeners();
  }

  // Specific entries delete karna
  Future<void> deleteMultipleEntries(List<int> indices) async {
    // List ko reverse sort karein taake delete karte waqt index galat na hon
    indices.sort((a, b) => b.compareTo(a));
    for (var index in indices) {
      if (index >= 0 && index < _history.length) {
        _history.removeAt(index);
      }
    }
    await _saveHistory();
    notifyListeners();
  }

  // SharedPreferences se history load karna
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyStringList = prefs.getStringList(_historyKey);

    if (historyStringList != null) {
      _history = historyStringList.map((jsonString) {
        final jsonMap = jsonDecode(jsonString); // String ko wapis Map mein badlein
        return PalindromeEntry.fromJson(jsonMap); // Map se object banayein
      }).toList();
    }
    notifyListeners();
  }

  // History ko SharedPreferences mein save karna
  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    // Har entry ko JSON string mein convert karein
    final historyStringList = _history.map((entry) {
      return jsonEncode(entry.toJson());
    }).toList();
    await prefs.setStringList(_historyKey, historyStringList);
  }
}