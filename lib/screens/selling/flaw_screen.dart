import 'package:flutter/material.dart';

class FlawScreen extends StatefulWidget {
  const FlawScreen({super.key});

  @override
  State<FlawScreen> createState() => _FlawScreenState();
}

class _FlawScreenState extends State<FlawScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Flaw Screen')),
    );
  }
}
