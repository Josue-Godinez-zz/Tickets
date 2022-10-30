import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/cinemas/cinema.dart';

class Cinemas extends StatefulWidget {
  const Cinemas({Key? key}) : super(key: key);

  @override
  State<Cinemas> createState() => _CinemasState();
}

class _CinemasState extends State<Cinemas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cinema")),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 6,
        itemBuilder: (_, index) => TextButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Cinema(
                        title: 'Nombre Cinema', // [TODO] Nombre del cinema
                        urlImage:
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'))); // [TODO] Url imagen del cinema
          },
          child: Card(
            child: Center(child: Text('Card element $index')),
          ),
        ),
      ),
    );
  }
}
