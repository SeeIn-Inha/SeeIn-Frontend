import '../api/user/pw_reset_api.dart';

final RegExp _pwReg = RegExp(r'^[A-Za-z0-9!_#^*&]{8,30}');
final RegExp _emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class PasswordEditor {
  Future<bool> resetPassword(String email, String pw, String pwCheck) async {
    if (!_emailReg.hasMatch(email)) {
      return false;
    }

    if (!_pwReg.hasMatch(pw)) {
      return false;
    }

    if (!(pw == pwCheck)) {
      return false;
    }

    final PWReset_Api pwReset = PWReset_Api();
    if (!await pwReset.reset(email, pw)) {
      return false;
    }

    return true;
  }
}