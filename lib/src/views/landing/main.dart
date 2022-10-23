import 'package:flutter/material.dart';
import 'package:light_carousel/light_carousel.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
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
      ]),
    );
  }
}
