// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:mongo_dart/mongo_dart.dart';
import 'package:venta_de_tickets/src/models/billingDto.dart';
import 'package:venta_de_tickets/src/models/scheduleDto.dart';

class DBConnection {
  static final DBConnection _instance = DBConnection._instance;
  static Db? _db;
  static DbCollection? _userCollection;
  static var _cinemasCollection;
  static var _filmsCollection;
  static var _scheduleCollection;
  static var _bookingCollection;
  static var _billingCollection;

  factory DBConnection() {
    return _instance;
  }

  static bool isConnected() {
    return _db!.isConnected;
  }

  static connect() async {
    _db = await Db.create(_getConnectionString());
    if (!isConnected()) {
      await _db!.open();
      _cinemasCollection = _db?.collection('Cinemas');
      _filmsCollection = _db?.collection('Peliculas');
      _scheduleCollection = _db?.collection('Schedule');
      // _bookingCollection = _db?.collection('Bookings');
      _billingCollection = _db!.collection('Billing');
    }
  }

  static closeConnection() {
    _db!.close();
  }

  static selectCollection(String collectionName) async {
    _userCollection = _db!.collection(collectionName);
  }

  static findOneData(Map<String, Object> data) {
    return _userCollection!.findOne(data);
  }

  static findData(Map<String, Object> data) {
    return _userCollection!.find(data).toList();
  }

  static findDataPaginated(Map<String, Object> data, int skip, int take) {
    return _userCollection!.find(data).skip(skip).take(take).toList();
  }

  static insertData(Map<String, Object> data) {
    _userCollection!.insert(data);
  }

  static updateOneSpecificData(
      Map<String, Object> consult, String field, Object value) {
    _userCollection!.updateOne(consult, modify.set(field, value));
  }

  static updateUpsert(Map<String, Object> consult, Map<String, Object> data) {
    _userCollection!.updateOne(consult, data, upsert: true);
  }

  static deleteData(Map<String, Object> data) {
    _userCollection!.deleteMany(data);
  }

  /// Return a list of cinemas
  static Future<List<Map<String, dynamic>>> getCinemas() async {
    final array = await _cinemasCollection.find().toList();
    return array;
  }

  /// Return a list of films of a cinema
  static Future<List<Map<String, dynamic>>> getFilmsByCinema(
      ObjectId cinemaId) async {
    final array =
        await _filmsCollection.find(where.eq('cinema', cinemaId)).toList();
    return array;
  }

  /// Return a list of shows of a movie
  static Future<List<Map<String, dynamic>>> getShowsByFilm(
      ObjectId filmId) async {
    final array =
        await _scheduleCollection.find(where.eq('film', filmId)).toList();
    return array;
  }

  // /// Return a list of booking of a show
  // static Future<List<Map<String, dynamic>>> getBookingsByShow(
  //     ObjectId showId) async {
  //   final array =
  //       await _bookingCollection.find(where.eq('show', showId)).toList();
  //   return array;
  // }

  // Update the data from the schedule
  static Future<String> saveScheduleData(ScheduleDto scheduleDto) async {
    scheduleDto.id ??= ObjectId();
    try {
      var resultUser = await _scheduleCollection.save(scheduleDto.toJson());
      return "Datos guardados correctamente";
    } catch (e) {
      return e.toString();
    }
  }

  // Save the data from the billing
  static Future<String> saveBillingData(BillingDto billingDto) async {
    billingDto.id ??= ObjectId();
    try {
      var resultUser = await _billingCollection.save(billingDto.toJson());
      return "Datos guardados correctamente";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<Map<String, dynamic>> getScheduleById(id) async {
    final result = await _scheduleCollection.findOne(where.eq('_id', id));
    return result;
  }

  static Future<Map<String, dynamic>> getFilmsById(id) async {
    final result = await _filmsCollection.findOne(where.eq('_id', id));
    return result;
  }

//
  static Future<Map<String, dynamic>> getCinemasById(id) async {
    final result = await _cinemasCollection.findOne(where.eq('_id', id));
    return result;
  }

  static Future<List<Map<String, dynamic>>> getPaymentsByUsers(
      ObjectId userId) async {
    final array =
        await _billingCollection.find(where.eq('user', userId)).toList();
    return array;
  }

  static Future<List<Map<String, dynamic>>> getTopCinemas() async {
    final array = await _cinemasCollection
        .find(where.sortBy('numberOfWeekSales', descending: true).limit(10))
        .toList();
    return array;
  }

  static String _getConnectionString() {
    return "mongodb+srv://jgodinez:una@cluster0.tajvs.mongodb.net/Dev-Gestion-De-Tickets?retryWrites=true&w=majority";
  }
}
