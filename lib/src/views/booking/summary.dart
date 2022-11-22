// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venta_de_tickets/src/util/AppContext.dart';
import '../../util/extentions.dart';
import '../paymentSection/paymentview.dart';

class Summary extends StatefulWidget {
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
  List<dynamic> chairStatus = [];
  Summary({super.key, required this.chairStatus});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool paying = false;
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

  @override
  Widget build(BuildContext context) {
    getChairs();
    return !paying
        ? SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Resumen"),
                centerTitle: true,
                backgroundColor: Theme.of(context).primaryColor,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).secondaryHeaderColor,
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
                child: Column(
                  children: [
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
                    Text(
                      "Si los asientos son correctos por favor continue con el siguiente paso.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Center(
                        child: Column(
                      children: [
                        // Text('SXS'),
                        MaterialButton(
                            onPressed: () => {
                                  setState(() => {paying = true})
                                },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 64,
                              height: MediaQuery.of(context).size.height * .08,
                              child: Center(
                                child: Text(
                                  'Pagar',
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
          )
        : PaypalPayment(onFinish: (number) => {log(number)});
  }
}
