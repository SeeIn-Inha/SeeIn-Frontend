import 'package:flutter/material.dart';
import 'package:seein_frontend/config/appTheme.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/common_widget.dart';
import '../../routes/router.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final CommonWidget widgetMaker = CommonWidget();
  final TextEditingController _pw = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final FocusNode _pwFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  // bool _isChecked = false;

  void _hideKeyboard(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
  }

  Widget _buildLoginLayout(BuildContext ctx, ThemeData theme) {
    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: h * 0.03),
          widgetMaker.buildBackButton(ctx, '로그인', theme),
          SizedBox(height: h * 0.02),
          widgetMaker.buildLabel(ctx, '이메일', theme),
          SizedBox(height: h * 0.01),
          widgetMaker.buildInputField(ctx, '이메일', _email, _emailFocus, theme),
          SizedBox(height: h * 0.02),
          widgetMaker.buildLabel(ctx, '비밀번호', theme),
          SizedBox(height: h * 0.01),
          widgetMaker.buildInputField(ctx, '비밀번호', _pw, _pwFocus, theme),
          SizedBox(height: h * 0.04,),
          widgetMaker.buildElavatedButton(ctx, '로그인', _email, _pw, null, null, theme),
          SizedBox(height: h * 0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('비밀번호를 잊으셨나요?', style: theme.textTheme.bodyMedium,),
              SizedBox(width: w * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(ctx, RoutePage.login);
                },
                child: Text('비밀번호 찾기', style: theme.textTheme.bodyMedium,),
              )
            ],
          ),
          SizedBox(height: h * 0.1,)
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
        child: _buildLoginLayout(ctx, theme),
      ),
    );
  }
}
