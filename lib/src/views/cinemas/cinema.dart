import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/widgets/ImageWithText.dart';

class Cinema extends StatefulWidget {
  const Cinema({Key? key}) : super(key: key);

  @override
  _CinemaState createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ImageWithText(
              text: 'Hola Mundo',
              urlImage:
                  'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg'),
          const Divider(),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 6,
            itemBuilder: (_, index) => TextButton(
              onPressed: () {},
              child: Card(
                child: Center(child: Text('Card element $index')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
