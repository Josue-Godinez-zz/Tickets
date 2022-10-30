import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:venta_de_tickets/src/components/background.dart';
import 'package:venta_de_tickets/src/components/customLoading.dart';
import 'package:venta_de_tickets/src/models/userdto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/services/encryptation.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';
import 'package:venta_de_tickets/src/views/login/loginController.dart';
import 'package:venta_de_tickets/src/views/login/signIn/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  Future<void> newUser() async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => const CustomLoading(type: 1),
    );
    await DBConnection.selectCollection('user');
    await DBConnection.insertData({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'username': _usernameController.text.trim(),
      'password': Encryptation.encrypt(
        _passwordController.text.trim(),
      ),
      'photo': "",
      'idPublication': 0
    });

    Future<Map<String, Object>> report = LoginController.signIn(
        _usernameController.text.trim(), _passwordController.text.trim());
    report.then((value) {
      if (value['status'] as bool) {
        SmartDialog.dismiss();
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Landing(
                user: LoginController.getUserDto()!,
              ),
            ));
      } else {
        SmartDialog.dismiss();
        SmartDialog.showToast(value['reason'] as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "REGISTER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: _nameController,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Email"),
                controller: _emailController,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Mobile Number"),
                controller: _phoneController,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Username"),
                controller: _usernameController,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Password"),
                controller: _passwordController,
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: MaterialButton(
                onPressed: () async {
                  SmartDialog.showLoading();
                  UserDto user = UserDto(
                      null,
                      _emailController.text,
                      _nameController.text,
                      _passwordController.text,
                      _phoneController.text,
                      _usernameController.text,
                      0);
                  Future<Map<String, Object>> logUp =
                      LoginController.signUp(user);

                  logUp.then((value) => {
                        if (value['status'] as bool)
                          {
                            SmartDialog.dismiss(),
                            Navigator.pop(context),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Landing(
                                    user: user,
                                  ),
                                ))
                          }
                        else
                          {
                            SmartDialog.dismiss(),
                            SmartDialog.showToast(value['reason'] as String)
                          }
                      });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()))
                },
                child: const Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
