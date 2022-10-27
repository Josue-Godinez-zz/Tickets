import 'package:flutter/material.dart';

class ImageWithText extends StatefulWidget {
  const ImageWithText({Key? key, required this.text, required this.urlImage})
      : super(key: key);
  final String text;
  final String urlImage;

  @override
  // ignore: library_private_types_in_public_api
  _ImageWithTextState createState() => _ImageWithTextState();
}

class _ImageWithTextState extends State<ImageWithText> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.network(
            widget.urlImage,
            height: 250,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            height: 230,
            child: Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0),
            )),
      ],
    );
  }
}
