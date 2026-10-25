import 'package:flutter/material.dart';

class WidgetDemoScreen extends StatelessWidget {
  const WidgetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Demo'),
      ),
      body: const Center(
        child: Text('Widget Demo Screen'),
      ),
    );
  }
}
