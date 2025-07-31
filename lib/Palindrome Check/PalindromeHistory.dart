import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/HistoryProvider.dart'; // Provider import karein

class PalindromeHistory extends StatelessWidget { // Isko StatelessWidget bana dein, state ab Provider manage karega
  const PalindromeHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch<T>() data ko sunta hai. Jab data change hoga, UI rebuild hoga.
    final historyProvider = context.watch<HistoryProvider>();
    final history = historyProvider.history;

    return Scaffold(
      appBar: AppBar(
        // ... AppBar ka code waisa hi rahega ...
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Palindrome History",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.yellow,
                Colors.green,
                Colors.blue,
              ],
            ),
          ),
        ),
      ),
      body: history.isEmpty
          ? const Center(
        child: Text(
          'No history available.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                entry.input,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${entry.isPalindrome ? "Is a palindrome" : "Is not a palindrome"} • ${entry.timestamp.toString().substring(0, 16)}',
                style: TextStyle(
                  fontSize: 18,
                  color: entry.isPalindrome ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text("Delete History"),
              content: const Text("Choose an option:"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    // Provider se history clear karein
                    context.read<HistoryProvider>().clearHistory();
                  },
                  child: const Text("Delete All", style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _showDeleteSpecificDialog(context); // Yahan parent context pass karein
                  },
                  child: const Text("Delete Specific", style: TextStyle(color: Colors.orange)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  // Is function ko class ke bahar ya andar, lekin build se bahar rakhein
  void _showDeleteSpecificDialog(BuildContext context) {
    // context.read se provider ko access karein, listen nahi karna
    final historyProvider = context.read<HistoryProvider>();
    final history = historyProvider.history;
    final selectedIndices = <int>{}; // Set of selected indices

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder( // StatefulBuilder zaroori hai dialog ke andar ki state ke liye
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Entries to Delete"),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final entry = history[index];
                    return CheckboxListTile(
                      value: selectedIndices.contains(index),
                      onChanged: (bool? value) {
                        setState(() { // Yeh sirf dialog ko update karega
                          if (value == true) {
                            selectedIndices.add(index);
                          } else {
                            selectedIndices.remove(index);
                          }
                        });
                      },
                      title: Text(entry.input),
                      subtitle: Text(
                        '${entry.isPalindrome ? "Is a palindrome" : "Is not a palindrome"} • ${entry.timestamp.toString().substring(0, 16)}',
                        style: TextStyle(
                          color: entry.isPalindrome ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Provider se selected entries delete karein
                    historyProvider.deleteMultipleEntries(selectedIndices.toList());
                    Navigator.pop(dialogContext);
                    // Ab screen khud update hojayegi 'cause of context.watch
                  },
                  child: const Text("Delete", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}