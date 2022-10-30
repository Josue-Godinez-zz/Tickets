import 'package:mongo_dart/mongo_dart.dart';

abstract class User {
  ObjectId? userId;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? photo;
  int? idPublication;
}
