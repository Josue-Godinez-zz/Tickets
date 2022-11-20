import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/models/filmDto.dart';
import 'package:venta_de_tickets/src/util/AppContext.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';

import '../../services/dbConnection.dart';
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
  List<FilmDto> cinemas = <FilmDto>[];
  bool isLoadingCinemas = false;

  @override
  void initState() {
    super.initState();
    getFilms();
  }

  void getFilms() {
    isLoadingCinemas = true;
    DBConnection.getFilmsByCinema(AppContext.getInstance().get('cinemaId'))
        .then((value) {
      List<FilmDto> filmsTemp = <FilmDto>[];
      for (var item in value) {
        filmsTemp.add(FilmDto.fromJson(item));
      }
      setState(() {
        isLoadingCinemas = false;
        cinemas.clear();
        cinemas.addAll(filmsTemp);
      });
    });
  }

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
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                    semanticContainer: false,
                    child: Center(
                        child: TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              AppContext.getInstance()
                                  .set('movieId', cinemas[index].id!);
                              AppContext.getInstance()
                                  .set('movieName', cinemas[index].name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Movie(
                                          title: cinemas[index]
                                              .name, // [TODO] Nombre del cinema
                                          urlImage: cinemas[index].urlImage!,
                                          description:
                                              cinemas[index].description,
                                          cinema: cinemas[
                                              index]))); // [TODO] Url imagen del cinema
                            },
                            child: Column(
                              children: [
                                cinemas[index].urlImage != ''
                                    ? Image.network(
                                        cinemas[index].urlImage!,
                                        // fit: BoxFit.cover,
                                        width: 90,
                                      )
                                    : Icon(
                                        Icons.local_movies,
                                        color: '#4f4f4f'.toColor(),
                                        size: 100,
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(cinemas[index].name,
                                      textAlign: TextAlign.center,
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      )),
                                ),
                              ],
                            )))); // [TODO] FORMA DE CADA PELICULA
              },
              childCount: cinemas.length, // [TODO] TAMANO TOTAL DE LA LISTA
            ),
          ),
        ],
      ),
    ));
  }
}
