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
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 6,
      itemBuilder: (_, index) => TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cinema()));
        },
        child: Card(
          child: Center(child: Text('Card element $index')),
        ),
      ),
    );
  }
}
