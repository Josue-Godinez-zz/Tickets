import 'package:venta_de_tickets/src/models/userdto.dart';
import 'package:venta_de_tickets/src/services/dbConnection.dart';
import 'package:venta_de_tickets/src/services/encryptation.dart';

import '../../interfaces/user.dart';

class LoginController {
  static final LoginController _instance = LoginController._instance;
  // static GoogleSignIn _googleSignIn = GoogleSignIn();
  static UserDto? _userDto;
  static User? _user;
  static bool gmailLogin = false;

  factory LoginController() {
    return _instance;
  }

  static void signUp() {}

  static Future<Map<String, Object>> signIn(
      String username, String password) async {
    try {
      await DBConnection.selectCollection('user');
      Map<String, dynamic>? user =
          await DBConnection.findOneData({'username': username});
      if (user != null) {
        if (user['password'] == Encryptation.encrypt(password)) {
          gmailLogin = false;
          _userDto = UserDto(
              user['_id'],
              user['email'],
              user['name'],
              user['password'],
              user['phone'],
              user['username'],
              user['idPublication'],
              photo: user['photo']);

          return {'status': true, 'reason': ''};
        } else {
          return {'status': false, 'reason': 'Incorrect Password'};
        }
      } else {
        return {'status': false, 'reason': 'There no username registraed'};
      }
    } catch (error) {
      return {'status': false, 'reason': error.toString()};
    }
  }

  static UserDto? getUserDto() {
    return _userDto;
  }

  static void setIdPublication() {
    _userDto!.setIdPublication(_userDto!.idPublication! + 1);
  }

  static User? getUser() {
    return _user;
  }

  static logOut() {
    _userDto = null;
  }
}
