import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';

import '../movie/movie.dart';
import '../schedule/schedule.dart';

class Cinema extends StatefulWidget {
  final String title;
  final String urlImage;
  const Cinema({Key? key, required this.title, required this.urlImage})
      : super(key: key);

  @override
  _CinemaState createState() => _CinemaState();
}

class _CinemaState extends State<Cinema> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            pinned: true,
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 300.0,
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
                  widget.urlImage != ''
                      ? Image.network(
                          widget.urlImage,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.local_movies,
                          color: '#ffffff'.toColor(),
                          size: 150,
                        ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20, child: SizedBox()),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              // childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                    child: Center(
                        child: TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Movie(
                                title:
                                    'Nombre Película', // [TODO] Nombre del cinema
                                urlImage:
                                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'))); // [TODO] Url imagen del cinema
                  },
                  child: Card(
                    child: Center(child: Text('Card element - $index')),
                  ),
                ))); // [TODO] FORMA DE CADA PELICULA
              },
              childCount: 30, // [TODO] TAMANO TOTAL DE LA LISTA
            ),
          ),
        ],
      ),
    ));
  }
}
