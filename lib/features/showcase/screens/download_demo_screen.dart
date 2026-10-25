import 'package:flutter/material.dart';

class DownloadDemoScreen extends StatelessWidget {
  const DownloadDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Demo'),
      ),
      body: const Center(
        child: Text('Download Demo Screen'),
      ),
    );
  }
}
