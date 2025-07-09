import 'package:flutter/material.dart';

class EssayScreen extends StatelessWidget {
  const EssayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Essay Task')),
      body: const Center(child: Text('Essay Input Placeholder')),
    );
  }
}
