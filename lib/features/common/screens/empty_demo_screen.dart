import 'package:flutter/material.dart';

class EmptyDemoScreen extends StatelessWidget {
  const EmptyDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty State Demo'),
      ),
      body: const Center(
        child: Text('Empty Demo Screen'),
      ),
    );
  }
}
