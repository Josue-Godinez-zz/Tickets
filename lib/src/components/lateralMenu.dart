// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/components/userHeader.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';
import 'package:venta_de_tickets/src/views/cinemas/cinemas.dart';
import 'package:venta_de_tickets/src/views/events/event.dart';
import 'package:venta_de_tickets/src/views/login/login.dart';
import 'package:venta_de_tickets/src/views/profile/profile.dart';

// ignore: camel_case_types
class lateralMenu extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  lateralMenu({Key? key}) : super(key: key);

  @override
  State<lateralMenu> createState() => _lateralMenuState();
}

// ignore: camel_case_types
class _lateralMenuState extends State<lateralMenu> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Column(
      children: [
        userHeader(),
        Divider(
          height: 20,
          thickness: 2,
          indent: 10,
          endIndent: 10,
          color: Theme.of(context).primaryColor,
        ),
        item(
            "Cines",
            Icon(
              Icons.movie_creation_outlined,
              color: Theme.of(context).primaryColor,
              size: 20,
            ), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cinemas()));
        }),
        item(
            "Eventos",
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
              size: 20,
            ), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Event()));
        }),
        item(
            "Mi cuenta",
            Icon(
              Icons.account_circle_rounded,
              color: Theme.of(context).primaryColor,
              size: 20,
            ), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        }),
        item(
            "Cerrar Sesión",
            Icon(
              Icons.logout_rounded,
              color: Theme.of(context).primaryColor,
              size: 20,
            ), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }),
      ],
    );
  }

  Widget item(title, icon, onPress) => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>('#ffffff'.toColor())),
            // ignore: sort_child_properties_last
            child: Row(
              children: [
                icon!,
                SizedBox(
                  width: 10,
                ),
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            onPressed: onPress,
          ),
        ),
      );
}
