class HistoryManager {
  static final HistoryManager _instance = HistoryManager._internal();

  factory HistoryManager() => _instance;

  HistoryManager._internal();

  final List<PalindromeEntry> _history = [];

  List<PalindromeEntry> get history => _history;

  void addEntry(PalindromeEntry entry) {
    _history.add(entry);
  }

  void clearHistory() {
    _history.clear();
  }

  void deleteMultipleEntries(List<int> indices) {
    indices.sort((a, b) => b.compareTo(a));
    for (var index in indices) {
      if (index >= 0 && index < _history.length) {
        _history.removeAt(index);
      }
    }
  }
}

class PalindromeEntry {
  final String input;
  final bool isPalindrome;
  final DateTime timestamp;

  PalindromeEntry(this.input, this.isPalindrome) : timestamp = DateTime.now();
}
