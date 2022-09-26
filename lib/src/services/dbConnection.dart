import 'package:mongo_dart/mongo_dart.dart';

class DBConnection {
  static final DBConnection _instance = DBConnection._instance;
  static Db? _db;
  static DbCollection? _userCollection;

  factory DBConnection() {
    return _instance;
  }

  static bool isConnected() {
    return _db!.isConnected;
  }

  static connect() async {
    _db = await Db.create(_getConnectionString());
    await _db!.open();
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

  static String _getConnectionString() {
    return "mongodb+srv://jgodinez:una@cluster0.tajvs.mongodb.net/Dev-Gestion-De-Tickets?retryWrites=true&w=majority";
  }
}
