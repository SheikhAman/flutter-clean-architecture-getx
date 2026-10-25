import 'package:flutter/material.dart';

class ThemeDemoScreen extends StatelessWidget {
  const ThemeDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
      ),
      body: const Center(
        child: Text('Theme Demo Screen'),
      ),
    );
  }
}
