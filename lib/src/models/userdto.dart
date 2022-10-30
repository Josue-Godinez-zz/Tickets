import 'package:bson/src/classes/object_id.dart';

import '../interfaces/user.dart';

class UserDto implements User {
  @override
  ObjectId? userId;

  @override
  String? email;

  @override
  String? name;

  @override
  String? password;

  @override
  String? phone;

  @override
  String? username;

  @override
  String? photo;

  @override
  int? idPublication;

  UserDto(this.userId, this.email, this.name, this.password, this.phone,
      this.username, this.idPublication,
      {this.photo = ''});

  void setIdPublication(idPublication) {
    this.idPublication = idPublication;
  }
}
