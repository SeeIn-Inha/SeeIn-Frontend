import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/user/login_api.dart';
import '../services/auth_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/common_widget.dart';
import '../routes/router.dart';
import '../api/user/fetch_my_info.dart';
import '../api/user/refresh_token_api.dart';

final Login_API loginManager = Login_API();
final CommonWidget widgetMaker = CommonWidget();
final FetchMyInfo_API fetchInfo = FetchMyInfo_API();

class Login {
  // 로그인 로직
  // API 호출 후, 결과 따라 멈추거나 홈 화면으로 이동
  Future<void> login(BuildContext ctx, String email, String pw, ThemeData theme) async {
    final AuthProvider authManager = ctx.read<AuthProvider>();
    if (!authManager.isFirstLogin) {
      // 토큰이 아예 없는 경우 >> 첫 로그인
      Map<String, dynamic> result = await loginManager.login(email: email, pw: pw);

      if (result['success'] == false) {
        widgetMaker.buildSnackBar(ctx, "아이디 또는 비밀번호를 확인해주세요!", theme);
        return;
      }
      await authManager.saveToken(result['access_token']);
      await fetch(ctx, email, pw, theme);
    } else if (!authManager.isTokenExpired) {
      // 토큰이 만료되었기 때문에 재발급 합니다
      final RefreshToken refreshToken = RefreshToken();
      await refreshToken.refeshToken(ctx, email, pw);
      await fetch(ctx, email, pw, theme);
    } else {
      // 정상 토큰 >> 바로 로그인, 내 정보 불러오기
      await fetch(ctx, email, pw, theme);
    }
  }

  Future<void> fetch(BuildContext ctx, String email, String pw, ThemeData theme) async {
    await fetchInfo.fetchMyInfo(ctx);
    widgetMaker.buildSnackBar(ctx, "로그인에 성공하였습니다!", theme);
    Navigator.pushReplacementNamed(ctx, RoutePage.realHome);
  }
}