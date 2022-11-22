// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venta_de_tickets/src/util/AppContext.dart';
import 'package:venta_de_tickets/src/views/booking/confirmation.dart';
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
  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var cityController = TextEditingController();
  var streetController = TextEditingController();
  var postalCodeController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool paying = false;
  var quantity = 0;
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
    setState(() {
      quantity = chairs.length;
    });
    return text;
  }

  Map<String, String> getBillingInfo() {
    return {
      "name": widget.nameController.text,
      "lastName": widget.lastNameController.text,
      "country": widget.countryController.text,
      "state": widget.stateController.text,
      "city": widget.cityController.text,
      "street": widget.streetController.text,
      "postalCode": widget.postalCodeController.text,
      "phone": widget.phoneController.text,
    };
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
                      child: Container(
                          // child: Column(
                          //   children: [
                          //     textFieldNoIcon(
                          //       'Nombre',
                          //       widget.nameController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Apellido',
                          //       widget.lastNameController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'País',
                          //       widget.countryController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Estado/Provincia',
                          //       widget.stateController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Ciudad',
                          //       widget.cityController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Calle',
                          //       widget.streetController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Codigo Postal',
                          //       widget.postalCodeController,
                          //     ),
                          //     textFieldNoIcon(
                          //       'Telefono',
                          //       widget.phoneController,
                          //     ),
                          //   ],
                          // ),
                          ),
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
        : PaypalPayment(
            onFinish: (id) => {
              log(id),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Confirmation(
                  chairStatus: widget.chairStatus,
                  id: id != null ? id : "",
                ),
              ))
            },
            billingData: getBillingInfo(),
            price: AppContext.getInstance().get("price"),
            quantity: quantity,
          );
  }

  Widget textFieldNoIcon(String text, controller, {nLines, validator}) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 500,
              height: 60,
              decoration: BoxDecoration(
                  color: "#E5E7E9".toColor(),
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: TextFormField(
                    onChanged: (value) {
                      log(value);
                    },
                    controller: controller,
                    maxLines: nLines,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: text,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: validator),
              ),
            ),
          ],
        ),
      );
}
