// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/models/userdto.dart';
import 'package:venta_de_tickets/src/util/AppContext.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';
import '../util/extentions.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  var image = "";
  bool isImage = false;
  UserDto userDto = AppContext.getInstance().get('user');

  @override
  void initState() {
    super.initState();
    isImage = userDto.photo != null && userDto.photo != '';
    if (isImage) {
      image = userDto.photo!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: addImage()),
            TextButton(
              onPressed: () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Landing(
                        user: UserDto(null, "", "", "", "", "", 0),
                      ),
                    ))
              },
              child: Text(
                userDto.name!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
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
                child: image == ''
                    ? Center(
                        child: !isImage
                            ? Icon(
                                Icons.person,
                                color: '#ffffff'.toColor(),
                                size: 40,
                              )
                            : null)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
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
