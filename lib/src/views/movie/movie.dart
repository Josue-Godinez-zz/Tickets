import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';
import 'package:venta_de_tickets/src/models/filmDto.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';

import '../../util/AppContext.dart';
import '../schedule/schedule.dart';

class Movie extends StatefulWidget {
  final String title;
  final String urlImage;
  final String description;
  final FilmDto cinema;
  const Movie(
      {Key? key,
      required this.title,
      required this.urlImage,
      required this.description,
      required this.cinema})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _Movie();
}

class _Movie extends State<Movie> {
  List<ScheduleDto> scheduleList = [];

  @override
  void initState() {
    super.initState();
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
                  widget.urlImage != ''
                      ? Image.network(
                          widget.urlImage,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.local_movies,
                          color: '#4f4f4f'.toColor(),
                          size: 100,
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
                    Text(scheduleList.length.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    // ignore: prefer_const_constructors
                    Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(widget.description)),
                    Center(
                        child: IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedule(
                                      title: widget
                                          .title, // [TODO] Nombre del cinema
                                      urlImage: widget.urlImage,
                                      idMovie: const [],
                                    ))); // [TODO] Url imagen del cinema
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
