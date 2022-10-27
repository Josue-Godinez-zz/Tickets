import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/cinemas/cinemas.dart';
import 'package:venta_de_tickets/src/views/events/event.dart';
import 'package:venta_de_tickets/src/views/landing/home.dart';
import 'package:venta_de_tickets/src/views/profile/profile.dart';

class Landing extends StatefulWidget {
  @override
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _Landing();
}

class _Landing extends State<Landing> {
  PageController page = PageController();
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // minimum: const EdgeInsets.all(0.0),
        child: Scaffold(
      // appBar: AppBar(
      //   title: const Text("Ticket App"),
      //   centerTitle: true,
      // ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              openSideMenuWidth: 200,
              displayMode: isOpen
                  ? SideMenuDisplayMode.open
                  : SideMenuDisplayMode.compact,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.blueGrey[900],
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              unselectedIconColor: Colors.white70,
              unselectedTitleTextStyle: const TextStyle(color: Colors.white70),
              // decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(0)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color.fromARGB(255, 79, 117, 134),
              //         spreadRadius: 1,
              //         blurRadius: 10,
              //         offset: Offset(0, 0), // changes position of shadow
              //       ),
              //     ]),
              backgroundColor: const Color.fromARGB(255, 79, 117, 134),
            ),
            title: Column(
              children: const [Text("IMAGEN"), Text("USERNAME"), Divider()],
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Inicio',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: const Icon(Icons.home),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Cines',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.video_collection_outlined),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Eventos',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.date_range),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Mi Cuenta',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Configuracion Perfil',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Cerrar Sesion',
                onTap: () {
                  page.jumpToPage(5);
                },
                icon: const Icon(Icons.logout),
              ),
              SideMenuItem(
                priority: 7,
                title: isOpen ? "Collapsar" : "Abrir",
                onTap: () {
                  isOpen = !isOpen;
                  setState(() {});
                },
                icon: Icon(isOpen
                    ? Icons.arrow_circle_left_outlined
                    : Icons.arrow_circle_right_outlined),
              )
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Home(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Cinemas(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text('Cinema'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Event(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Profile(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
