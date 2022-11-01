import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/booking/booking.dart';
import 'package:video_player/video_player.dart';

class Schedule extends StatefulWidget {
  final String title;
  final String urlImage;
  const Schedule({Key? key, required this.title, required this.urlImage})
      : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
                  Image.network(
                    widget.urlImage,
                    fit: BoxFit.cover,
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
                            builder: (context) => Booking(
                                  movieName: 'TEST',
                                  moviePlayerController:
                                      VideoPlayerController.asset(
                                          "assets/video/mulanclip.mp4"),
                                  reflectionPlayerController:
                                      VideoPlayerController.asset(
                                          "assets/video/mulanclip.mp4"),
                                ))); // [TODO] Url imagen del cinema
                  },
                  child: Card(
                    child: Center(child: Text('Card element $index')),
                  ),
                ))); // [TODO] FORMA DE CADA PELICULA
              },
              childCount: 3, // [TODO] TAMANO TOTAL DE LA LISTA
            ),
          ),
        ],
      ),
    ));
    ;
  }
}
