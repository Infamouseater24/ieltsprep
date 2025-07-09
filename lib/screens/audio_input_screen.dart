import 'package:flutter/material.dart';

class AudioInputScreen extends StatelessWidget {
  const AudioInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Task')),
      body: const Center(child: Text('Audio Input Placeholder')),
    );
  }
}
