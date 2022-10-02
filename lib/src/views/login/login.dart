import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/login/signIn/signin.dart';
import 'package:venta_de_tickets/src/views/login/signUp/signUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.black,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.login),
              text: "Login",
            ),
            Tab(
              icon: Icon(Icons.login),
              text: "Register",
            )
          ],
        ),
        body: TabBarView(children: <Widget>[SignIn(), SignUp()]),
      ),
    );
  }
}
