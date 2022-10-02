import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Username"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const <Widget>[Text("Nombre"), Text("Genero")],
                ),
                Column(
                  children: const <Widget>[Text("Apellidos"), Text("Cedula")],
                )
              ],
            ),
            CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
                onDateChanged: (DateTime) {}),
            const Text("Password"),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Landing()));
              },
              child: const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
