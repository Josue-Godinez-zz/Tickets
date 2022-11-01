// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venta_de_tickets/src/models/cinemaDto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/util/extentions.dart';
import 'package:venta_de_tickets/src/views/cinemas/cinema.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/lateralMenu.dart';
import '../../util/AppContext.dart';

class Cinemas extends StatefulWidget {
  Cinemas({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Cinemas> createState() => _CinemasState();
}

class _CinemasState extends State<Cinemas> {
  List<CinemaDto> cinemas = <CinemaDto>[];
  bool isLoadingCinemas = false;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getCinemas();
  }

  void getCinemas() {
    isLoadingCinemas = true;
    DBConnection.getCinemas().then((value) {
      List<CinemaDto> cinemasTemp = <CinemaDto>[];
      for (var item in value) {
        cinemasTemp.add(CinemaDto.fromJson(item));
      }
      setState(() {
        isLoadingCinemas = false;
        cinemas.clear();
        cinemas.addAll(cinemasTemp);
      });
    });
  }

  ///Method to refresh the list of products
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getCinemas();
    _refreshController.refreshCompleted();
  }

  ///Another method to refresh the list of products but when the user
  ///try to scroll in the end of the list(No is in use)
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Ticket +"),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(27, 10, 0, 10),
              child: title('Cines'),
            ),
            Expanded(
                child: !isLoadingCinemas
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

  Widget title(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );

  Widget listView() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Container(
          height: 630,
          width: 600,
          decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: cinemas.isEmpty
              ? Center(
                  child: const Text("No hay Cines",
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

                        itemCount: cinemas.length,
                        // itemExtent: 50,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                            child: itemListView(cinemas[index]),
                          );
                        },
                      ),
                    ),
                  )),
        ),
      );

  ///Component for the items of the listview
  Widget itemListView(CinemaDto cinema) => Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Cinema(
                title: cinema.name,
                urlImage: cinema.urlImage!,
              ),
            )),
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(cinema.toString(),
                style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.none,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      );
}
