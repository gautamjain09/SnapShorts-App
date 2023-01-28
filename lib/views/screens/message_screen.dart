import 'package:flutter/material.dart';
import 'package:snapshorts_app/constants.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat & Messages",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
    );
  }
}
