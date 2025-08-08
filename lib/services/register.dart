final RegExp _idReg = RegExp(r'^[a-z0-9]{3,15}$');
final RegExp _pwReg = RegExp(r'^[A-Za-z0-9!@_#$^*&]{8,30}');
final RegExp _emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class Regist {
  static Map<String, bool>? invalidData(String id, String pw, String email) {
    if (!_idReg.hasMatch(id)) {
      return ({id: false});
    }

    if (!_pwReg.hasMatch(pw)) {
      return ({pw: false});
    }

    if (!_emailReg.hasMatch(email)) {
      return ({email: false});
    }

    return ({"success": true});
  }
}