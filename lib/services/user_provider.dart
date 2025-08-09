import 'package:flutter/material.dart';
// 사용자 정보 관리 클래스
class UserProvider extends ChangeNotifier {
  String? email;
  String? username;

  void setUserData(Map<String, dynamic>? data) {
    // api로 요청한 내 정보 저장
    if (data == null) {
      return;
    }

    email = data["email"];
    username = data["username"];
    notifyListeners();
  }

  void clearUserData() {
    email = null;
    username = null;
    notifyListeners();
  }
}