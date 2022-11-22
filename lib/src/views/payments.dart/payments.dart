// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venta_de_tickets/src/components/lateralMenu.dart';
import 'package:venta_de_tickets/src/models/billingDto.dart';
import 'package:venta_de_tickets/src/models/cinemaDto.dart';
import 'package:venta_de_tickets/src/models/filmDto.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';

import '../../models/userdto.dart';
import '../../services/dbConnection.dart';
import '../../util/AppContext.dart';

class Payments extends StatefulWidget {
  Payments({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isLoadingPayments = false;
  var payments = [];
  UserDto userDto = AppContext.getInstance().get('user');

  ///Method to refresh the list of products
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // getCinemas();
    getUserPayments();
    _refreshController.refreshCompleted();
  }

  void getUserPayments() {
    isLoadingPayments = true;
    DBConnection.getPaymentsByUsers(userDto.userId!).then((value) async {
      List<Map<dynamic, dynamic>> billingTemp = <Map<dynamic, dynamic>>[];
      for (var item in value) {
        BillingDto b = BillingDto.fromJson(item);
        ScheduleDto s = ScheduleDto.fromJson(
            await DBConnection.getScheduleById(b.scheduleId!));

        FilmDto f =
            FilmDto.fromJson((await DBConnection.getFilmsById(b.filmId!)));
        CinemaDto c =
            CinemaDto.fromJson(await DBConnection.getCinemasById(f.cinemaId));
        billingTemp.add({"billing": b, "cinema": c, "film": f, "schedule": s});
      }
      setState(() {
        isLoadingPayments = false;
        payments.clear();
        payments.addAll(billingTemp);
      });
    });
  }

  ///Another method to refresh the list of products but when the user
  ///try to scroll in the end of the list(No is in use)
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    getUserPayments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Mis Compras"),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).secondaryHeaderColor,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: '#ffffff'.toColor(),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 80,
            ),
            Expanded(child: lateralMenu()),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(27, 10, 0, 10),
            //   child: title('Cines'),
            // ),
            Expanded(
                child: !isLoadingPayments
                    ? listView()
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
            // bigButton("Nuevo Producto", () {
            //   Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => EditProduct(
            //       product: Product.empty(),
            //     ),
            //   ));
            // }, Theme.of(context).primaryColor)
          ],
        ),
      ),
    ));
  }

  Widget listView() => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          height: 630,
          width: 600,
          decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: payments.isEmpty
              ? Center(
                  child: const Text("Aún no hay pagos",
                      style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold)))
              : MediaQuery.removeViewPadding(
                  context: context,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      header: WaterDropMaterialHeader(
                        distance: 80,
                      ),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text("pull up load");
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = Text("Load Failed!Click retry!");
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text("release to load more");
                          } else {
                            body = Text("No more Data");
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,

                        itemCount: payments.length,
                        // itemExtent: 50,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: itemListView(payments[index]),
                          );
                        },
                      ),
                    ),
                  )),
        ),
      );

  String getChairs(chairStatus) {
    var chairs = [];
    for (var row in chairStatus) {
      var x = chairStatus.indexOf(row);
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
    // setState(() {
    //   quantity = chairs.length;
    // });
    return text;
  }

  Widget itemListView(Map<dynamic, dynamic> payment) {
    double height = 10;
    return Container(
      height: 167,
      decoration: BoxDecoration(
        color: '#d9d9d9'.toColor(),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextButton(
          // onPressed: () => {
          //       AppContext.getInstance().set('cinemaId', cinema.id!),
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => Cinema(
          //           title: cinema.name,
          //           urlImage: cinema.urlImage!,
          //         ),
          //       )),
          //     },
          onPressed: () => {},
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                // height: 167,
                decoration: BoxDecoration(
                  color: '#d9d9d9'.toColor(),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_movies,
                      color: '#4f4f4f'.toColor(),
                      size: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(payment['cinema'].name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: height,
                            ),
                            Text(payment['film'].name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: height,
                            ),
                            Row(
                              children: [
                                Text(payment['schedule'].day,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: height,
                                ),
                                Text(payment['schedule'].hour,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: height,
                            ),
                            Text('Sala: ' + payment['schedule'].room,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: height,
                            ),
                            Text(
                                'Asientos: ' +
                                    getChairs(payment['billing'].chairs)
                                        .toUpperCase(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
