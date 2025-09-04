import 'package:flutter/material.dart';

class CookItScreen extends StatelessWidget {
  const CookItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CookItScreen"),
      ),
      body: const Center(child: Text("CookItScreen"),),
    );
  }
}
