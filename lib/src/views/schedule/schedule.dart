import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';
import 'package:venta_de_tickets/src/views/booking/booking.dart';
import 'package:video_player/video_player.dart';

import '../../services/dbConnection.dart';
import '../../util/AppContext.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  final String title;
  final String urlImage;
  final List<List<int>> idMovie;
  const Schedule(
      {Key? key,
      required this.title,
      required this.urlImage,
      required this.idMovie})
      : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<ScheduleDto> shows = <ScheduleDto>[];

  @override
  void initState() {
    super.initState();
    getSchedules();
  }

  void getSchedules() {
    DBConnection.getShowsByFilm(AppContext.getInstance().get('movieId'))
        .then((value) {
      List<ScheduleDto> showsTemp = <ScheduleDto>[];
      for (var item in value) {
        showsTemp.add(ScheduleDto.fromJson(item));
      }
      setState(() {
        shows.clear();
        shows.addAll(showsTemp);
        shows.sort((a, b) => DateFormat('dd/mm/yyyy')
            .parse(a.day)
            .compareTo(DateFormat('dd/mm/yyyy').parse(b.day)));
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
            pinned: false,
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: MediaQuery.of(context).size.height / 5,
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
                    AppContext.getInstance().set('showId', shows[index].id!);
                    AppContext.getInstance().set('filmName', widget.title);
                    AppContext.getInstance().set('day', shows[index].day);
                    AppContext.getInstance().set('hour', shows[index].hour);
                    AppContext.getInstance().set('room', shows[index].room!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Booking(
                                  movieName:
                                      AppContext.getInstance().get('movieName'),
                                  moviePlayerController:
                                      VideoPlayerController.asset(
                                          "assets/video/mulanclip.mp4"),
                                  // VideoPlayerController.asset(
                                  //     "assets/video/mulanclip.mp4"),
                                  reflectionPlayerController:
                                      VideoPlayerController.asset(
                                          "assets/video/mulanclip-reflection.mp4"),
                                ))); // [TODO] Url imagen del cinema
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // cinemas[index].urlImage != ''
                      //     ? Image.network(
                      //         cinemas[index].urlImage!,
                      //         // fit: BoxFit.cover,
                      //         width: 90,
                      //       )
                      //     : Icon(
                      //         Icons.local_movies,
                      //         color: '#4f4f4f'.toColor(),
                      //         size: 100,
                      //       ),

                      Center(
                        child: Text("Dia: ${shows[index].day}",
                            textAlign: TextAlign.center,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                            "Hora: ${DateFormat('hh:mm').format(DateFormat('hh:mm').parse(shows[index].hour))}",
                            textAlign: TextAlign.center,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Sala: ${shows[index].room}",
                            textAlign: TextAlign.center,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            )),
                      ),
                    ],
                  ),
                ))); // [TODO] FORMA DE CADA FUNCION
              },
              childCount: shows.length, // [TODO] TAMANO TOTAL DE LA LISTA
            ),
          ),
        ],
      ),
    ));
    ;
  }
}
