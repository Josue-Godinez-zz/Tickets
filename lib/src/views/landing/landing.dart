import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _Landing();
}

class _Landing extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("landing")),
    );
  }
}
