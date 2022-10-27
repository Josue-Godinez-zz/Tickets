import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/landing/home.dart';

class CustomSidebarDrawer extends StatefulWidget {
  final Function drawerClose;

  const CustomSidebarDrawer({Key? key, required this.drawerClose})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSidebarDrawerState createState() => _CustomSidebarDrawerState();
}

class _CustomSidebarDrawerState extends State<CustomSidebarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.60,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/devs.jpg",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Flutter Devs")
                ],
              )),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            leading: const Icon(Icons.home),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
