import 'package:flutter/material.dart';

import '../schedule/schedule.dart';

class Movie extends StatefulWidget {
  final String title;
  final String urlImage;
  const Movie({Key? key, required this.title, required this.urlImage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _Movie();
}

class _Movie extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            pinned: true,
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: MediaQuery.of(context).size.height / 1.4,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(widget.title),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    widget.urlImage,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 1),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x90000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                // height: MediaQuery.of(context).size.height / 0.5,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descripción',
                        style: Theme.of(context).textTheme.headline6),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec interdum arcu turpis, a lobortis mauris egestas nec. Etiam tempus quis elit ac pulvinar. Nam vel luctus nisi. Pellentesque maximus euismod massa condimentum dapibus. Praesent aliquet urna et libero egestas venenatis'),
                    ),
                    Center(
                        child: IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Schedule(
                                    title:
                                        'Nombre Cinema2', // [TODO] Nombre del cinema
                                    urlImage:
                                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'))); // [TODO] Url imagen del cinema
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 50,
                      ),
                    )), // [TODO] Descripcion de la pelicula
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}
