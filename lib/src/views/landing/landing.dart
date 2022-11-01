// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/components/lateralMenu.dart';
import 'package:venta_de_tickets/src/models/userdto.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';
import 'package:venta_de_tickets/src/views/landing/home.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Landing extends StatefulWidget {
  UserDto user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Landing({Key? key, required this.user}) : super(key: key);

  @override
  State<Landing> createState() => _Landing();
}

class _Landing extends State<Landing> {
  PageController page = PageController();
  bool isOpen = false;
  late VideoPlayerController _moviePlayerController;
  late VideoPlayerController _reflectionPlayerController;

  @override
  void initState() {
    super.initState();
    _moviePlayerController =
        VideoPlayerController.asset("assets/video/mulanclip.mp4")..initialize();
    _reflectionPlayerController =
        VideoPlayerController.asset("assets/video/mulanclip.mp4")..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // minimum: const EdgeInsets.all(0.0),
        child: Scaffold(
            key: widget._scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text("Ticket +"),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
            ),
            drawer: Drawer(
              backgroundColor: '#ffffff'.toColor(),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Expanded(child: lateralMenu()),
                ],
              ),
            ),
            body: Home()));
  }
}
