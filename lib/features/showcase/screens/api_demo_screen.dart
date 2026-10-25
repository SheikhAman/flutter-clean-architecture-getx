import 'package:flutter/material.dart';

class ApiDemoScreen extends StatelessWidget {
  const ApiDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Demo'),
      ),
      body: const Center(
        child: Text('API Demo Screen'),
      ),
    );
  }
}
