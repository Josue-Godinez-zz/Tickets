import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/widgets/ImageWithText.dart';
import 'package:venta_de_tickets/src/widgets/customappbar.dart';

class Cinema extends StatefulWidget {
  const Cinema({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CinemaState createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(areaName: 'Cinema', returnArea: Areas.landing),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              itemCount: 8,
              itemBuilder: (_, index) => TextButton(
                onPressed: () {},
                child: Card(
                  child: Center(child: Text('Card element $index')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
