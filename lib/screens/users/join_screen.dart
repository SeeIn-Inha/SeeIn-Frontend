import 'package:flutter/material.dart';
import '../../widgets/drawer_widget.dart';
import '../../routes/router.dart';
import '../../widgets/common_widget.dart';
import 'package:seein_frontend/config/appTheme.dart';

class JoinPage extends StatefulWidget {
  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pw = TextEditingController();
  final TextEditingController _pwCheck = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _pwFocus = FocusNode();
  final FocusNode _pwCheckFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  bool _isUsernameFocused = false;
  bool _isPwFocused = false;
  bool _isPwCheckFocused = false;
  bool _isEmailFocused = false;

  @override
  void initState() {
    super.initState();

    _usernameFocus.addListener(() {
      setState(() {
        _isUsernameFocused = _usernameFocus.hasFocus;
      });
    });

    _pwFocus.addListener(() {
      setState(() {
        _isPwFocused = _pwFocus.hasFocus;
      });
    });

    _pwCheckFocus.addListener(() {
      setState(() {
        _isPwCheckFocused = _pwCheckFocus.hasFocus;
      });
    });

    _emailFocus.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _pwFocus.dispose();
    _pwCheckFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _hideKeyboard(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
  }

  // -----------------------------------------------위젯 시작----------------------------------------------------
  @override
  Widget build(BuildContext ctx) {
    final theme = AppTheme.lightTheme;
    final CommonWidget widgetMaker = CommonWidget();

    Widget _buildJoinLayout(BuildContext ctx, ThemeData theme) {
      final w = MediaQuery.of(ctx).size.width;
      final h = MediaQuery.of(ctx).size.height;

      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: h * 0.03),
            widgetMaker.buildBackButton(ctx, '회원가입', theme),
            SizedBox(height: h * 0.02),
            widgetMaker.buildLabel(ctx, '아이디', theme),
            SizedBox(height: h * 0.01),
            widgetMaker.buildInputField(ctx, '아이디', _username, _usernameFocus, theme),
            if (_isUsernameFocused) ...[
              SizedBox(height: h * 0.01,),
              Text('아이디는 2~20자, 한글, 영문, 숫자, 공백만 사용 가능합니다'),
            ],
            SizedBox(height: h * 0.02),
            widgetMaker.buildLabel(ctx, '이메일', theme),
            SizedBox(height: h * 0.01),
            widgetMaker.buildInputField(ctx, '이메일', _email, _emailFocus, theme),
            if (_isEmailFocused) ...[
              SizedBox(height: h * 0.01,),
              Text('예: example@domain.com'),
            ],
            SizedBox(height: h * 0.02),
            widgetMaker.buildLabel(ctx, '비밀번호', theme),
            SizedBox(height: h * 0.01),
            widgetMaker.buildInputField(ctx, '비밀번호', _pw, _pwFocus, theme),
            if (_isPwFocused) ...[
              SizedBox(height: h * 0.01,),
              Text('비밀번호는 8~30자, 영문, 숫자, 특수문자(!_#^*&)만 허용됩니다.'),
            ],
            SizedBox(height: h * 0.02),
            widgetMaker.buildLabel(ctx, '비밀번호 확인', theme),
            SizedBox(height: h * 0.01),
            widgetMaker.buildInputField(ctx, '비밀번호 확인', _pwCheck, _pwCheckFocus, theme),
            if (_isPwCheckFocused) ...[
              SizedBox(height: h * 0.01,),
              Text('비밀번호를 다시 한번 입력해주세요.'),
            ],
            SizedBox(height: h * 0.04,),
            widgetMaker.buildElavatedButton(ctx, '회원가입', _email, _pw, _pwCheck, _username, theme),
            SizedBox(height: h * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('이미 계정이 있으신가요?', style: theme.textTheme.bodyMedium,),
                SizedBox(width: w * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(ctx, RoutePage.login);
                  },
                  child: Text('로그인', style: theme.textTheme.bodyMedium,),
                )
              ],
            ),
            SizedBox(height: h * 0.1,)
          ],
        ),
      );
    }

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
        child: _buildJoinLayout(ctx, theme),
      ),
    );
  }
}
