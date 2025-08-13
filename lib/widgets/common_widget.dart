import 'package:flutter/material.dart';
import '../config/widget_config.dart';
import '../services/login.dart';
import '../services/register.dart';

class CommonWidget {
  Widget buildInputField(BuildContext ctx, String label, TextEditingController textEditor, FocusNode? focus, ThemeData theme) {
    final config = WidgetConfig.inputSettings[label] ?? {
      'hint': '$label을 입력하세요',
      'keyboard': TextInputType.text,
      'obscure': false,
    };

    final w = MediaQuery.of(ctx).size.width;

    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );

      return SizedBox(
        width: w * 0.8,
        child: TextField(
          controller: textEditor,
          focusNode : focus,
          keyboardType: config['keyboard'] as TextInputType,
          obscureText: config['obscure'] as bool,
          minLines: null,
          maxLines: 1,
          style: theme.textTheme.titleMedium,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 20, horizontal: 10
            ),
            hintText: config['hint'] as String,
            enabledBorder: borderStyle,
            border: borderStyle,
          ),
        ),
      );

  }

  Widget buildElavatedButton(BuildContext ctx, String label, TextEditingController? emailController, TextEditingController? pwController, TextEditingController? pwCheckController, TextEditingController? usernameController , ThemeData theme) {
    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;

    return SizedBox(
      width: w * 0.8,
        height: h * 0.06,
        child: ElevatedButton(
            onPressed: () async {
              final email = emailController?.text.trim();
              final pw = pwController?.text.trim();
              final pwCheck = pwCheckController?.text.trim();
              final username = usernameController?.text.trim();
              final Regist registManager = Regist();
              final Login loginMnager = Login();
              String contents = "";
              bool isValid = false;
              switch (label) {
                case '로그인':
                  if (email == null || email.trim().isEmpty) {
                    contents = "이메일을 입력해주세요";
                    break;
                  } else if (pw == null || pw.trim().isEmpty) {
                    contents = "비밀번호를 입력해주세요";
                    break;
                  }
                  await loginMnager.login(ctx, email, pw, theme);
                  isValid = true;
                  break;
                case '회원가입':
                  if (username == null || username.trim().isEmpty) {
                    contents = "아이디를 입력해주세요";
                    break;
                  } else if (email == null || email.trim().isEmpty) {
                    contents = "이메일을 입력해주세요";
                    break;
                  } else if (pw == null || pw.trim().isEmpty) {
                    contents = "비밀번호를 입력해주세요";
                    break;
                  } else if (pwCheck == null || pwCheck.trim().isEmpty) {
                    contents = "비밀번호를 다시 한번 입력해주세요";
                    break;
                  } else if (!(pwCheck == pw)){
                    contents = "비밀번호가 일치하지 않습니다";
                    break;
                  }
                  await registManager.register(ctx, email, pw, pwCheck, username, theme);
                  isValid = true;
                  break;
              }
              if (!isValid) {
                buildSnackBar(ctx, contents, theme);
              }

              emailController?.clear();
              pwController?.clear();
              pwCheckController?.clear();
              usernameController?.clear();
            },
            style: theme.elevatedButtonTheme.style,
          child: Text(label, style: theme.textTheme.labelLarge,),
        ),
    );
  }

  void buildSnackBar(BuildContext ctx, String text, ThemeData theme) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(text, style: theme.textTheme.bodyMedium,),
      backgroundColor: Colors.white,));
  }

  Widget buildBackButton(BuildContext ctx, String label, ThemeData theme) {
    final w = MediaQuery.of(ctx).size.width;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: w * 0.05),
      child: Row(
        children: [
          IconButton(
            // 뒤로 가기 버튼
            onPressed: () {
              Navigator.pop(ctx);
            },
            icon: Icon(Icons.arrow_back),
          ),
          Text(
            label,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget buildLabel(BuildContext ctx, String label, ThemeData theme) {
    final w = MediaQuery.of(ctx).size.width;

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: w * 0.12),
      child: Text(
        label,
        style: theme.textTheme.titleMedium,
      ),
    );
  }

}