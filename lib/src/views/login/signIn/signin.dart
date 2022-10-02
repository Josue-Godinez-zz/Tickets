import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          const Text("User"),
          const Text("Password"),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Landing()));
              },
              child: const Text("Login"))
        ],
      ),
    ));
  }
}
