import 'package:flutter/material.dart';

import 'package:venta_de_tickets/src/views/cinemas/cinema.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';
import 'package:venta_de_tickets/src/views/login/loginController.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget {
  Areas returnArea;
  String areaName;
  CustomAppBar({Key? key, required this.returnArea, required this.areaName})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBar();
}

enum Areas { landing, cinema, schedule, movie }

class _CustomAppBar extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
              switch (widget.returnArea) {
                case Areas.landing:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Landing(user: LoginController.getUserDto()!)));
                  break;
                case Areas.cinema:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Cinema(
                                title: '',
                                urlImage: '',
                              )));
                  break;
                case Areas.schedule:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Cinema(
                                title: '',
                                urlImage: '',
                              )));
                  break;
                case Areas.movie:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Cinema(
                                title: '',
                                urlImage: '',
                              )));
                  break;
              }
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        Text(widget.areaName)
      ],
    );
  }
}
