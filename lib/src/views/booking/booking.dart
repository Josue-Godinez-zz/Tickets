import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:venta_de_tickets/src/models/bookingDto.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/util/AppContext.dart';
import 'package:venta_de_tickets/src/views/booking/summary.dart';
import 'package:venta_de_tickets/src/widgets/app_widget.dart';
import 'package:venta_de_tickets/src/widgets/videoclipper.dart';
import 'package:venta_de_tickets/src/widgets/videoclipper2.dart';
import 'package:video_player/video_player.dart';

class Booking extends StatefulWidget {
  final String movieName;
  final VideoPlayerController moviePlayerController;
  final VideoPlayerController reflectionPlayerController;

  const Booking(
      {super.key,
      required this.moviePlayerController,
      required this.reflectionPlayerController,
      required this.movieName});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> with TickerProviderStateMixin {
  Size get _size => MediaQuery.of(context).size;
  List<AnimationController> _dateSelectorACList = [];
  List<Animation<double>> _dateSelectorTweenList = [];

  List<AnimationController> _timeSelectorACList = [];
  List<Animation<double>> _timeSelectorTweenList = [];

  late AnimationController _dateBackgroundAc;
  late Animation<double> _dateBackgroundTween;

  late AnimationController _cinemaScreenAc;
  late Animation<double> _cinemaScreenTween;

  late AnimationController _reflectionAc;
  late Animation<double> _reflectionTween;

  late AnimationController _payButtonAc;
  late Animation<double> _payButtonTween;

  late AnimationController _cinemaChairAc;
  late Animation<double> _cinemaChairTween;

  int _dateIndexSelected = 1;
  int _timeIndexSelected = 1;
  List<dynamic> _chairStatus = [];
  bool isSelectedChairs = false;

  bool isLoadingBookins = false;

  @override
  void initState() {
    super.initState();
    getSeats();
    getChairs();
    initializeAnimation();
    widget.moviePlayerController.setLooping(true);
    widget.reflectionPlayerController.setLooping(true);
    widget.moviePlayerController.initialize();
    widget.moviePlayerController.play();
    widget.reflectionPlayerController.play();
  }

  void getChairs() {
    DBConnection.getScheduleById(AppContext.getInstance().get('showId'))
        .then((value) {
      ScheduleDto scheduleDto;
      if (value != null) {
        scheduleDto = ScheduleDto.fromJson(value);
        _chairStatus = scheduleDto.chairs;
        AppContext.getInstance().set('scheduleDto', scheduleDto);
        setState(() {});
      }
    });
  }

  void checkSelection() {
    var chairs = [];
    for (var row in _chairStatus) {
      for (var i = 0; i < row.length; i++) {
        if (row[i] == 4) {
          chairs.add(row[i]);
        }
      }
    }
    chairs.length > 0 ? setState(() => {isSelectedChairs = true}) : null;
  }

  void getSeats() {
    isLoadingBookins = true;
    DBConnection.getBookingsByShow(AppContext.getInstance().get('showId'))
        .then((value) {
      List<BookingDto> bookingsTemp = <BookingDto>[];
      for (var item in value) {
        bookingsTemp.add(BookingDto.fromJson(item));
      }
      setState(() {
        isLoadingBookins = false;
        for (var seat in bookingsTemp) {
          _chairStatus[int.parse(seat.row)][int.parse(seat.column)] = 2;
        }
      });
    });
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg,
        duration: duration,
        gravity: gravity,
        // ignore: prefer_const_constructors
        textStyle: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15,
            color: Colors.white));
  }

  void initializeAnimation() {
    // initialize dateSelector List
    for (int i = 0; i < 7; i++) {
      _dateSelectorACList.add(AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500)));
      _dateSelectorTweenList.add(Tween<double>(begin: 1000, end: 0)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(_dateSelectorACList[i]));
      Future.delayed(Duration(milliseconds: i * 50 + 170), () {
        _dateSelectorACList[i].forward();
      });
    }

    // initialize dateSelector Background
    _dateBackgroundAc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _dateBackgroundTween = Tween<double>(begin: 1000, end: 0)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_dateBackgroundAc);
    Future.delayed(const Duration(milliseconds: 150), () {
      _dateBackgroundAc.forward();
    });

    // initialize timeSelector List
    for (int i = 0; i < 3; i++) {
      _timeSelectorACList.add(AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500)));
      _timeSelectorTweenList.add(Tween<double>(begin: 1000, end: 0)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(_timeSelectorACList[i]));
      Future.delayed(Duration(milliseconds: i * 25 + 100), () {
        _timeSelectorACList[i].forward();
      });
    }

    // initialize cinemaScreen
    _cinemaScreenAc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _cinemaScreenTween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_cinemaScreenAc);
    Future.delayed(const Duration(milliseconds: 800), () {
      _cinemaScreenAc.forward();
    });

    // initialize reflection
    _reflectionAc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _reflectionTween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_reflectionAc);
    Future.delayed(const Duration(milliseconds: 1800), () {
      _reflectionAc.forward();
    });

    // paybutton
    _payButtonAc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _payButtonTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_payButtonAc);
    Future.delayed(const Duration(milliseconds: 800), () {
      _payButtonAc.forward();
    });

    // chair
    _cinemaChairAc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));
    _cinemaChairTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_cinemaChairAc);
    Future.delayed(const Duration(milliseconds: 1200), () {
      _cinemaChairAc.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[_appBar(), _cinemaRoom(), _payButton()],
        ),
      ),
    );
  }

  Widget _cinemaRoom() {
    return Expanded(
        flex: 47,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: _size.width,
            ),
            Positioned(
              top: 48,
              child: ClipPath(
                clipper: VideoClipper2(),
                child: AnimatedBuilder(
                  animation: _reflectionAc,
                  builder: (ctx, child) {
                    return Opacity(
                      opacity: _reflectionTween.value,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .8,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: _size.height * .02,
                child: AnimatedBuilder(
                    animation: _cinemaChairTween,
                    builder: (ctx, child) {
                      return Transform.translate(
                        offset: Offset(0, _cinemaChairTween.value * 100),
                        child: Opacity(
                            opacity: _cinemaChairTween.value + 1, child: child),
                      );
                    },
                    child: SizedBox(
                        width: _size.width, child: GenerateChairList()))),
          ],
        ));
  }

  Widget _payButton() {
    return Expanded(
      flex: 13,
      child: AnimatedBuilder(
        animation: _payButtonAc,
        builder: (ctx, child) {
          double opacity() {
            if (_payButtonTween.value + 1 < 0.2) {
              return (_payButtonTween.value + 1) * 5;
            }
            return 1;
          }

          return Transform.translate(
            offset: Offset(0, _payButtonTween.value * 200),
            child: Opacity(opacity: opacity(), child: child),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _chairCategory(Colors.white, "LIBRE"),
                  _chairCategory(AppColor.primary, "TUYO"),
                  _chairCategory(Colors.grey, "OCUPADO"),
                  _chairCategory(Colors.red, "NO DISPONIBLE"),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
              child: MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  checkSelection();
                  isSelectedChairs
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Summary(
                                    chairStatus: _chairStatus,
                                  )))
                      : showToast(
                          "Por favor seleccione al menos un asiento para continuar.",
                          gravity: Toast.bottom,
                          duration: 1);
                },
                child: SizedBox(
                  width: _size.width - 64,
                  height: _size.height * .08,
                  child: const Center(
                    child: Text(
                      'Reservar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chairCategory(Color color, String category) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2), color: color),
        ),
        Text(
          category,
          style: const TextStyle(
              fontSize: 12, color: Colors.grey, fontFamily: "Bebas-Neue"),
        ),
      ],
    );
  }

  Widget GenerateChairList() {
    List<Row> chairs = <Row>[];
    for (int x = 0; x < _chairStatus.length; x++) {
      List<Widget> row = <Widget>[];
      for (int y = 0; y < _chairStatus[x].length; y++) {
        row.add(GestureDetector(
          onTap: () {
            if (_chairStatus[x][y] == 1) {
              setState(() {
                _chairStatus[x][y] = 4;
              });
            } else if (_chairStatus[x][y] == 4) {
              setState(() {
                _chairStatus[x][y] = 1;
              });
            }
          },
          child: Container(
            height: 25,
            width: 25,
            margin: const EdgeInsets.all(5),
            child: _chairStatus[x][y] == 1
                ? AppWidget.whiteChair()
                : _chairStatus[x][y] == 2
                    ? AppWidget.greyChair()
                    : _chairStatus[x][y] == 3
                        ? AppWidget.redChair()
                        : _chairStatus[x][y] == 5
                            ? Container()
                            : AppWidget.yellowChair(),
          ),
        ));
      }
      chairs.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: chairs,
    );
  }

  Widget _chairList() {
    // 0 is null
    // 1 is free
    // 2 is reserved
    // 3 is notavailable
    // 4 is yours

    return Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(top: i == 3 ? _size.height * .02 : 0),
            child: Row(
              children: <Widget>[
                for (int x = 0; x < 9; x++)
                  Expanded(
                    flex: x == 0 || x == 8 ? 2 : 1,
                    child: x == 0 ||
                            x == 8 ||
                            (i == 0 && x == 1) ||
                            (i == 0 && x == 7) ||
                            (i == 3 && x == 1) ||
                            (i == 3 && x == 7) ||
                            (i == 5 && x == 1) ||
                            (i == 5 && x == 7)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (_chairStatus[i][x - 1] == 1) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 4;
                                });
                              } else if (_chairStatus[i][x - 1] == 4) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 1;
                                });
                              }
                            },
                            child: Container(
                              height: _size.width / 11 - 10,
                              margin: const EdgeInsets.all(5),
                              child: _chairStatus[i][x - 1] == 1
                                  ? AppWidget.whiteChair()
                                  : _chairStatus[i][x - 1] == 2
                                      ? AppWidget.greyChair()
                                      : _chairStatus[i][x - 1] == 3
                                          ? AppWidget.redChair()
                                          : AppWidget.yellowChair(),
                            ),
                          ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _appBar() {
    return Expanded(
      flex: 8,
      child: Container(
        width: _size.width,
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              widget.movieName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Positioned(
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
