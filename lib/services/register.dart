import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/user/register_api.dart';
import '../widgets/common_widgt.dart';
import '../routes/router.dart';

final RegExp _usernameReg = RegExp(r'^[a-zA-Z0-9가-힣 ]{2,20}$');
final RegExp _pwReg = RegExp(r'^[A-Za-z0-9!_#^*&]{8,30}');
final RegExp _emailReg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class Regist {
  final CommonWidget widgetMaker = CommonWidget();

  Map<String, dynamic> _invalidData(String username, String pw, String email) {
    if (!_usernameReg.hasMatch(username)) {
      return ({"valid": false, "detail": "아이디 규칙 위배"});
    }

    if (!_pwReg.hasMatch(pw)) {
      return ({"valid": false, "detail": "비밀번호 규칙 위배"});
    }

    if (!_emailReg.hasMatch(email)) {
      return ({"valid": false, "detail": "이메일 규칙 위배"});
    }

    return ({"valid": true, "detail": "success"});
  }

  Future<void> register(BuildContext ctx, String email, String pw, String pwCheck, String username, ThemeData theme) async {
    Map<String, dynamic> validReuslt = _invalidData(username, pw, email);
    String text = "";

    if (validReuslt["valid"] == false) {
      switch (validReuslt["detail"]) {
        case "아이디 규칙 위배":
          text = "아이디는 특수문자, 영대문자를 포함할 수 없습니다";
          break;
        case "이메일 규칙 위배":
          text = "이메일을 다시 한번 확인해주세요";
          break;
        case "비밀번호 규칙 위배":
          text = "비밀번호를 확인해주세요";
          break;
        default:
          break;
      }
      widgetMaker.buildSnackBar(ctx, text, theme);
      return;
    }

    final Regist_API registManager = Regist_API();
    final registResult = await registManager.register(username: username, pw: pw, email: email);

    if (registResult["success"] == false) {
      widgetMaker.buildSnackBar(ctx, "회원가입에 실패하였습니다", theme);
      return;
    }

    widgetMaker.buildSnackBar(ctx, "회원가입에 성공하였습니다", theme);
    Navigator.pushNamed(ctx, RoutePage.login);
  }
}