import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palindrome_app/Palindrome%20Check/PalindromeLoad.dart';
import 'package:provider/provider.dart'; // Provider import karein
import 'Providers/HistoryProvider.dart'; // Naya provider import karein

void main() {
  runApp(
    // App ko ChangeNotifierProvider se wrap karein
    ChangeNotifierProvider(
      create: (context) => HistoryProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Palindrome Check App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CupertinoColors.activeGreen),
      ),
      home: const Palindromeload(),
    );
  }
}