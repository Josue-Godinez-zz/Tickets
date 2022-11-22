// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:light_carousel/light_carousel.dart';
import 'package:venta_de_tickets/src/models/cinemaDto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';

final List<Widget> containers = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  addCinemas() async {
    containers.clear();
    List topCinemas = await DBConnection.getTopCinemas();
    List<CinemaDto> t = List.from(topCinemas.map((e) => CinemaDto.fromJson(e)));
    for (var c in t) {
      // CinemaDto c = CinemaDto.fromJson(cinema);
      containers.add(Container(
        decoration: BoxDecoration(
          color: "#E5E7E9".toColor(),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          // border: Border.all(color: '#7f7f7f'.toColor()),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: Offset(3, 3))
          // ]
        ),
        child: Center(
            child: TextButton(
                onPressed: () {
                  // [TODO] Url imagen del film
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    c.urlImage != ''
                        ? Image.network(
                            c.urlImage!,
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
                      child: Text(c.name,
                          textAlign: TextAlign.center,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )),
                    ),
                  ],
                ))),
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    addCinemas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 150.0,
          child: LightCarousel(
            borderRadius: true,
            boxFit: BoxFit.cover,
            autoPlay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: const Duration(milliseconds: 2000),
            dotSize: 3.0,
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            radius: const Radius.circular(20),
            showIndicator: true,
            indicatorBgPadding: 7.0,
            images: const [
              NetworkImage(
                  'https://img.freepik.com/free-vector/games-time-neon-text-with-gamepad_1262-15457.jpg?w=2000'),
              NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/002/144/780/original/gaming-banner-for-games-with-glitch-effect-neon-light-on-text-illustration-design-free-vector.jpg'),
              NetworkImage(
                  'https://img.freepik.com/premium-vector/simple-unique-gaming-banner-template_92741-92.jpg?w=2000'),
              NetworkImage(
                  'https://as1.ftcdn.net/v2/jpg/04/13/99/08/1000_F_413990886_hChS8igRgaOC4IlkIFIxiQ2EeW5U8LKf.jpg'),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
              child: Text(
                'Top 10 cines populares',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.9,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: containers,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: containers.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
