// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venta_de_tickets/src/models/billingDto.dart';
import 'package:venta_de_tickets/src/models/filmDto.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';
import 'package:venta_de_tickets/src/models/userdto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/views/landing/landing.dart';

import '../../util/AppContext.dart';

class Confirmation extends StatefulWidget {
  List<dynamic> chairStatus = [];
  var id = '';
  var alphabet = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];
  Confirmation({Key? key, required this.chairStatus, required this.id});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  ScheduleDto scheduleDto = AppContext.getInstance().get('scheduleDto');
  FilmDto filmDto = AppContext.getInstance().get('movie');
  UserDto userDto = AppContext.getInstance().get('user');
  String getChairs() {
    var chairs = [];
    for (var row in widget.chairStatus) {
      var x = widget.chairStatus.indexOf(row);
      for (var i = 0; i < row.length; i++) {
        var y = i;
        if (row[i] == 4) {
          chairs.add(widget.alphabet[x].toString() + (y + 1).toString());
        }
      }
    }
    String text = '';
    for (var i = 0; i < chairs.length; i++) {
      text += i != chairs.length - 1 ? "${chairs[i]}, " : chairs[i];
    }
    return text;
  }

  void replaceSelection() {
    for (var row in widget.chairStatus) {
      for (var i = 0; i < row.length; i++) {
        if (row[i] == 4) {
          row[i] = 2;
        }
      }
    }
    scheduleDto.chairs = widget.chairStatus;
  }

  void saveData() async {
    BillingDto billingDto = BillingDto(
        id: null,
        filmId: filmDto.id,
        scheduleId: scheduleDto.id,
        userId: userDto.userId,
        chairs: widget.chairStatus);
    await DBConnection.saveBillingData(billingDto);
    replaceSelection();
    await DBConnection.saveScheduleData(scheduleDto);
  }

  @override
  void initState() {
    if (widget.id != "") {
      saveData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Compra"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: widget.id != ""
              ? Column(
                  children: [
                    Text(
                      "Su compra se ha realizado con éxito",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sus asientos para la pelicula ${AppContext.getInstance().get('filmName')}, para el día ${AppContext.getInstance().get('day')} a las ${DateFormat('hh:mm').format(DateFormat('hh:mm').parse(AppContext.getInstance().get('hour')))} son:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getChairs(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "En la Sala ${AppContext.getInstance().get('room')}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: Column(
                      children: [
                        Text(
                            'RECUERDE TOMAR UN SCREENSHOT PARA GUARDAR LA COMPRA REALIZADA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            onPressed: () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Landing(
                                          user: UserDto(
                                              null, "", "", "", "", "", 0),
                                        ),
                                      ))
                                },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 64,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Center(
                                child: Text(
                                  'Volver al Inicio',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            )),
                      ],
                    ))
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Ocurrio un error al realizar la compra por favor vuelva al inicio he intentelo de nuevo",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                          child: Center(
                        child: Icon(
                          Icons.error_outline_sharp,
                          color: Theme.of(context).primaryColor,
                          size: 80,
                        ),
                      )),
                    ),
                    Center(
                        child: Column(
                      children: [
                        MaterialButton(
                            onPressed: () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Landing(
                                          user: UserDto(
                                              null, "", "", "", "", "", 0),
                                        ),
                                      ))
                                },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 64,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Center(
                                child: Text(
                                  'Volver al Inicio',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            )),
                      ],
                    ))
                  ],
                ),
        )),
      ),
    );
  }
}
