// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../util/extentions.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
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
              SizedBox(
                width: 10,
                height: 0,
              ),
            ],
          ),
        ],
      );
}
