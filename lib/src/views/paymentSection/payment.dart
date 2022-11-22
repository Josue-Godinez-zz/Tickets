// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/views/paymentSection/paymentview.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool paying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !paying
            ? Column(mainAxisAlignment: MainAxisAlignment.center,
                // children: !paying
                children: [
                    Text("Payment"),
                    ElevatedButton(
                        onPressed: () => {
                              setState(() => {paying = true})
                            },
                        child: Text(!paying ? 'Prueba PayPal' : 'Pagando'))
                  ])
            // : PaypalPayment(onFinish: () => {}),
            : PaypalPayment(
                onFinish: (number) => {log(number)},
                billingData: {},
                price: "0.0",
                quantity: 0,
              ),
      ),
    );
  }
}
