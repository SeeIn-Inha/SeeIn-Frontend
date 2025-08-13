import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/user/login_api.dart';
import '../services/auth_provider.dart';
import '../widgets/common_widgt.dart';
import '../routes/router.dart';

class Login {
  // 로그인 로직
  // API 호출 후, 결과 따라 멈추거나 홈 화면으로 이동
  static Future<void> login(BuildContext ctx, String email, String pw, ThemeData theme) async {
    final AuthProvider authManager = AuthProvider();
    final Login_API loginManager = Login_API();
    final CommonWidget widgetMaker = CommonWidget();

    // if (!authManager.isTokenValid) {
    //   print("토큰 기간 만료");
    //   return;
    // }

    Map<String, dynamic> result = await loginManager.login(email: email, pw: pw);

    if (result['success'] == false) {
      widgetMaker.buildSnackBar(ctx, "아이디 또는 비밀번호를 확인해주세요!", theme);
      return;
    }
    await authManager.saveToken(result['access_token']);
    widgetMaker.buildSnackBar(ctx, "로그인에 성공하였습니다!", theme);
    Navigator.pushReplacementNamed(ctx, RoutePage.home);
  }
}