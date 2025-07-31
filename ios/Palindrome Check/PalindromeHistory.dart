import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HistoryManager.dart';
import 'PalindromeCheck.dart'; // Make sure HistoryManager is imported

class PalindromeHistory extends StatefulWidget {
  const PalindromeHistory({super.key});

  @override
  State<PalindromeHistory> createState() => _PalindromeHistoryState();
}

class _PalindromeHistoryState extends State<PalindromeHistory> {
  @override
  Widget build(BuildContext context) {
    final history = HistoryManager().history; // Get the history

    return Scaffold(
      appBar: AppBar(
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
            builder: (context) => AlertDialog(
              title: const Text("Delete History"),
              content: const Text("Choose an option:"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      HistoryManager().clearHistory(); // Delete all
                    });
                  },
                  child: const Text("Delete All", style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDeleteSpecificDialog();
                  },
                  child: const Text("Delete Specific", style: TextStyle(color: Colors.orange)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
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

  void _showDeleteSpecificDialog() {
    final history = HistoryManager().history;
    final selected = <int>{};

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
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
                      value: selected.contains(index),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selected.add(index);
                          } else {
                            selected.remove(index);
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      HistoryManager().deleteMultipleEntries(selected.toList());
                    });
                    Navigator.pop(context);
                    this.setState(() {}); // Refresh screen
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
