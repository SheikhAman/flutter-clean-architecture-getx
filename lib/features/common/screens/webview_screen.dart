import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: const Center(
        child: Text('WebView Screen'),
      ),
    );
  }
}
