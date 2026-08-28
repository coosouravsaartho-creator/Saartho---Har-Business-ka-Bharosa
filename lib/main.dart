import 'package:flutter/material.dart';

void main() {
  runApp(const SaarthoApp());
}

class SaarthoApp extends StatelessWidget {
  const SaarthoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saartho',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Saartho'),
        ),
        body: const Center(
          child: Text(
            'Saartho is ready!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
