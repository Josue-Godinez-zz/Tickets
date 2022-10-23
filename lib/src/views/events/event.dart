import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _Events();
}

class _Events extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("EVENTOS"),
    );
  }
}
