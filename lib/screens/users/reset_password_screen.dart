import 'package:flutter/material.dart';
import 'package:seein_frontend/config/appTheme.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/common_widget.dart';
import 'package:provider/provider.dart';
import '../../services/reset_password.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pw = TextEditingController();
  final TextEditingController _pwCheck = TextEditingController();
  final FocusNode _pwFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwCheckFocus = FocusNode();

  void _hideKeyboard(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
  }

  Widget _buildLayout(BuildContext ctx, ThemeData theme) {
    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;
    final CommonWidget widgetMaker = CommonWidget();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: h * 0.03),
          widgetMaker.buildBackButton(ctx, '비밀번호 찾기', theme),
          SizedBox(height: h * 0.02),
          widgetMaker.buildLabel(ctx, '이메일', theme),
          SizedBox(height: h * 0.01),
          widgetMaker.buildInputField(ctx, '이메일', _email, _emailFocus, theme),
          SizedBox(height: h * 0.02),
          widgetMaker.buildLabel(ctx, '비밀번호', theme),
          SizedBox(height: h * 0.01),
          widgetMaker.buildInputField(ctx, '비밀번호', _pw, _pwFocus, theme),
          SizedBox(height: h * 0.02),
          widgetMaker.buildLabel(ctx, '비밀번호 확인', theme),
          SizedBox(height: h * 0.01),
          widgetMaker.buildInputField(ctx, '비밀번호 확인', _pwCheck, _pwCheckFocus, theme),
          SizedBox(height: h * 0.02),
          ElevatedButton(
            onPressed: () async {
              final PasswordEditor pwEditor = PasswordEditor();
              if (!await pwEditor.resetPassword(_email.text.trim(), _pw.text.trim(), _pwCheck.text.trim())) {
                widgetMaker.buildSnackBar(ctx, '비밀번호나 이메일을 확인해주세요', theme);
                return;
              }
              widgetMaker.buildSnackBar(ctx, '비밀번호 변경에 성공하였습니다!', theme);
              _email.clear();
              _pw.clear();
              _pwCheck.clear();
              Navigator.pushNamed(ctx, '/start');
            },
            child: Text('비밀번호 변경', style: theme.textTheme.labelSmall,),
          ),
          SizedBox(height: h * 0.04,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    final theme = AppTheme.lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(child: Menu()),
      body: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => _hideKeyboard(ctx),
        child: _buildLayout(ctx, theme),
      ),
    );
  }
}