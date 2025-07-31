import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider import karein

import '../Providers/HistoryProvider.dart';
import 'PalindromeHistory.dart';

class Palindromecheck extends StatefulWidget {
  const Palindromecheck({super.key});

  @override
  State<Palindromecheck> createState() => _PalindromecheckState();
}

class _PalindromecheckState extends State<Palindromecheck> {
  final TextEditingController _controller = TextEditingController();
  String _resultMessage = '';

  bool _isPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = cleanText.split('').reversed.join('');
    return cleanText == reversedText;
  }

  void _checkPalindrome() {
    String inputText = _controller.text;
    if (inputText.isEmpty) {
      setState(() {
        _resultMessage = 'Please enter some text!';
      });
      return;
    }
    bool isPalindrome = _isPalindrome(inputText);
    setState(() {
      _resultMessage = isPalindrome
          ? 'The string is a palindrome.'
          : 'The string is not a palindrome.';
    });

    // Save to history using Provider
    // context.read<T>() ya Provider.of<T>(context, listen: false) use karte hain functions call karne ke liye
    final historyProvider = context.read<HistoryProvider>();
    historyProvider.addEntry(
      PalindromeEntry(
        input: inputText,
        isPalindrome: isPalindrome,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ... baaki code waisa hi rahega ...
    // ... just build method ke andar koi change nahi ...
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Palindrome Checker',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor:CupertinoColors.activeGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Palindrome",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              'A palindrome is a word, phrase, number, or other sequence of characters that reads the same forward and backward, ignoring spaces, punctuation, and capitalization.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Here's An Interface to check String Of Palindrome",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter text to check',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkPalindrome,
              style: ElevatedButton.styleFrom(
                backgroundColor: CupertinoColors.activeGreen,
              ),
              child: const Text(
                'Check Palindrome',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _resultMessage,
              style: TextStyle(
                fontSize: 20,
                color: _resultMessage.contains('not') ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PalindromeHistory(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Show History",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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