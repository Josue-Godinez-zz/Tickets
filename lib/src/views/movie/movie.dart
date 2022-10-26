import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Movie();
}

class _Movie extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("PELICULA"),
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
