import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:venta_de_tickets/src/components/background.dart';
import 'package:venta_de_tickets/src/components/customLoading.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';
import 'package:venta_de_tickets/src/views/login/loginController.dart';
import 'package:venta_de_tickets/src/views/login/signUp/signUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(40, 0, 5, 0),
                  child: Text(
                    "Ticket Plus",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Text(
                    "+",
                    style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   padding: const EdgeInsets.fromLTRB(45, 0, 10, 0),
            //   child: Text(
            //     "Log in",
            //     style: Theme.of(context).textTheme.bodySmall,
            //     textAlign: TextAlign.left,
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: const InputDecoration(labelText: "Password"),
                controller: _passwordController,
                obscureText: true,
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            //   child: Text(
            //     "Forgot your password?",
            //     style: Theme.of(context).textTheme.labelMedium,
            //   ),
            // ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    splashColor:
                        Theme.of(context).buttonTheme.colorScheme!.background,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    onPressed: () async {
                      if (_usernameController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        SmartDialog.showLoading(
                          animationType: SmartAnimationType.scale,
                          builder: (_) => const CustomLoading(type: 1),
                        );

                        Future<Map<String, Object>> report =
                            LoginController.signIn(_usernameController.text,
                                _passwordController.text);

                        report.then((value) {
                          if (value['status'] as bool) {
                            SmartDialog.dismiss();
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Landing(),
                                ));
                          } else {
                            SmartDialog.dismiss();
                            SmartDialog.showToast(value['reason'] as String);
                          }
                        });
                      } else {
                        if (_usernameController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          SmartDialog.showToast('Field Required');
                        } else {
                          if (_usernameController.text.isEmpty) {
                            SmartDialog.showToast('Username Field Required');
                          }
                          if (_passwordController.text.isEmpty) {
                            SmartDialog.showToast('Password Field Required');
                          }
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    textColor: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0)),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 30),
                  //   Container(
                  //     decoration: BoxDecoration(boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black12,
                  //         spreadRadius: 0,
                  //         blurRadius: 10,
                  //         offset: Offset(4, 6),
                  //       )
                  //     ]),
                  //     child: MaterialButton(
                  //       onPressed: () async {
                  //         User? user = await LoginController.signInWithGmail();
                  //         if (user != null) {
                  //           Navigator.pop(context);
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => const Menu(),
                  //               ));
                  //         }
                  //       },
                  //       color: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(90.0)),
                  //       padding: const EdgeInsets.all(0),
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         height: 40.0,
                  //         width: size.width * 0.1,
                  //         child: Image.asset("assets/images/googleLogo.png",
                  //             width: size.width),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()))
                },
                child: Text(
                  "Don't Have an Account? Sign up",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const AboutUs()))
                },
                child: Text(
                  "About us",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
