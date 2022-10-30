// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../util/extentions.dart';

class userHeader extends StatefulWidget {
  userHeader({Key? key}) : super(key: key);

  @override
  State<userHeader> createState() => _userHeaderState();
}

class _userHeaderState extends State<userHeader> {
  final image = null;
  bool isImage = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: addImage()),
            Text(
              'User Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ]),
    );
  }

  Widget addImage() => Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            children: [
              Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: image == null
                      ? Center(
                          child: !isImage
                              ? Icon(
                                  Icons.person,
                                  color: '#ffffff'.toColor(),
                                  size: 40,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  // child: base64ToImage(businessA.image),
                                ),
                        )
                      : null
                  // ClipRRect(
                  //     borderRadius: BorderRadius.circular(100),
                  //     child: Image.file(
                  //       File(image!.path!),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  ),
              // ignore: prefer_const_constructors
              SizedBox(
                width: 10,
                height: 0,
              ),
            ],
          ),
        ],
      );
}
