import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LostAndFoundApp());
}

class LostAndFoundApp extends StatefulWidget {
  const LostAndFoundApp({Key? key}) : super(key: key);

  @override
  State<LostAndFoundApp> createState() => _LostAndFoundAppState();
}

class _LostAndFoundAppState extends State<LostAndFoundApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}