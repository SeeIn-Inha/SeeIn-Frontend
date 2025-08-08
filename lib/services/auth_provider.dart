import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 로그인 토큰을 관리하는 클래스 입니다
class AuthProvider extends ChangeNotifier {
  String? _token;
  DateTime? _expiry;
  String? get token => _token;
  bool get isLoggedIn => _token != null;
  bool get isTokenValid {
    if (_token == null || _expiry == null) return false;
    return DateTime.now().isBefore(_expiry!);
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void clearToken() async {
    _token = null;
    _expiry = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('token_expiry');

    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final expiryString = prefs.getString('token_expiry');

    if (expiryString != null) {
      _expiry = DateTime.tryParse(expiryString);
    }

    notifyListeners();
  }
  // , int expireMinutes
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    _token = token;
    // _expiry = DateTime.now().add(Duration(minutes: expireMinutes));

    await prefs.setString('token', _token!);
    // await prefs.setString('toekn_expiry', _expiry!.toIso8601String());
    print("토큰 저장 완료");
    print("토큰: " + prefs.getString('token').toString());
    // print("유효기간: " + prefs.getString('token_expiry').toString());
    notifyListeners();
  }
}