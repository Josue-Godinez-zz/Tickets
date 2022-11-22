// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './../../services/PaypalService/paypalService.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  var billingData = {};
  var price = '0';
  var quantity = 0;
  var rateCurrency = 615;

  PaypalPayment(
      {required this.onFinish,
      required this.billingData,
      required this.price,
      required this.quantity});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl = '';
  String? executeUrl = '';
  String? accessToken = '';
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res.isNotEmpty) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: $e');
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // _scaffoldKey.currentState?.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 2;

  Map<String, dynamic> getOrderParams() {
    var price = double.parse(
        (double.parse(widget.price) / widget.rateCurrency).toStringAsFixed(2));
    List items = [
      {
        "name": "Tiquete",
        "quantity": widget.quantity,
        "price": price.toString(),
        "currency": defaultCurrency["currency"]
      },
    ];
    num total = 0;
    items.forEach((element) {
      total += (double.parse((double.parse(widget.price) / widget.rateCurrency)
              .toStringAsFixed(2)) *
          widget.quantity);
    });
    // checkout invoice details
    String totalAmount = total.toString();
    String subTotalAmount = total.toString();
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": '$userFirstName $userLastName',
                "line1": widget.billingData["street"],
                "line2": "",
                "city": widget.billingData["city"],
                "country_code": widget.billingData["country"],
                "postal_code": widget.billingData["postalCode"],
                "phone": widget.billingData["phone"],
                "state": widget.billingData["state"]
              },
          }
        }
      ],
      "note_to_payer": "Disfruta la pelicula y gracias por la compra.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    var x = checkoutUrl.toString();

    if (checkoutUrl!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(
                        Uri.parse(executeUrl!), payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                });
              }
              // else {
              //   Navigator.of(context).pop();
              // }
              // Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
