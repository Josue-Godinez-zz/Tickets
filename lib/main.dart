import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';
import 'package:venta_de_tickets/src/views/movie/movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Movie(),
    );
  }
}
