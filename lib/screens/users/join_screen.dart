import 'package:flutter/material.dart';
import 'package:text_divider/text_divider.dart';
import '../../widgets/drawer_widget.dart';
import '../../routes/router.dart';
import '../../services/register.dart';
import '../../api/user/register_api.dart';

class JoinPage extends StatefulWidget {
  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final TextEditingController _nick = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final FocusNode _nickFocus = FocusNode();
  final FocusNode _pwFocus = FocusNode();
  final FocusNode _pwCheck = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  bool _isNickFocused = false;
  bool _isPwFocused = false;
  bool _isPwChecked = false;
  bool _isSamePw = false;
  bool _emailFocused = false;

  @override
  void initState() {
    super.initState();

    _nickFocus.addListener(() {
      setState(() {
        _isNickFocused = _nickFocus.hasFocus;
      });
    });

    _pwFocus.addListener(() {
      setState(() {
        _isPwFocused = _pwFocus.hasFocus;
      });
    });

    _pwCheck.addListener(() {
      setState(() {
        _isPwChecked = _pwCheck.hasFocus;
      });
    });

    _emailFocus.addListener(() {
      setState(() {
        _emailFocused = _emailFocus.hasFocus;
        // print("이메일 포커싱: ${_emailFocused.toString()}");
      });
    });
  }

  void makeSnackBar(BuildContext context, String target) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // padding: EdgeInsets.only(left: 20.0),
        backgroundColor: Colors.white,
        content: Text(target, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  @override
  void dispose() {
    _nickFocus.dispose();
    _pwFocus.dispose();
    _pwCheck.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // -----------------------------------------------위젯 시작----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _hideKeyboard,
      // -------------------------------------------상단 메뉴----------------------------------------------------
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
        ),
        drawer: Drawer(child: Menu()),
        // ----------------------------------------본문 시작------------------------------------------------------
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      IconButton(
                        // 뒤로 가기 버튼
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        '회원 가입',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                // ------------------------------------닉네임-------------------------------------------
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    '닉네임',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                // 아이디 레이블
                SizedBox(height: 2),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: TextField(
                    controller: _nick,
                    focusNode: _nickFocus,
                    minLines: null,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hintText: '닉네임을 입력하세요',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                // 아이디 입력 컨테이너
                if (_isNickFocused) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '닉네임은 2~20자, 영문/한글/숫자/공백만 허용됩니다',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
                SizedBox(height: 15),
                // ----------------------------------------이메일-------------------------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    '이메일',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                // 아이디 레이블
                SizedBox(height: 2),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    focusNode: _emailFocus,
                    minLines: null,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hintText: '이메일 입력하세요',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                // 아이디 입력 컨테이너
                if (_emailFocused) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '이메일을 입력해주세요',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
                SizedBox(height: 15),
                // ---------------------------------------비밀번호-------------------------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    '비밀번호',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                // 비밀번호 레이블
                SizedBox(height: 2),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: TextField(
                    controller: _password,
                    focusNode: _pwFocus,
                    obscureText: true,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hintText: '비밀번호를 입력하세요',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF4B4737),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF4B4737),
                        ),
                      ),
                    ),
                  ),
                ),
                // 비밀번호 입력 컨테이너
                if (_isPwFocused) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '비밀번호는 8자~30자의 특수문자를 포함할 수 있습니다',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
                SizedBox(height: 15),
                // ------------------------------------비밀번호 확인----------------------------------------------
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    '비밀번호 확인',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                // 비밀번호 확인 레이블
                SizedBox(height: 2),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: TextField(
                    controller: _passwordCheck,
                    focusNode: _pwCheck,
                    onChanged:
                        (_) => {
                          // 입력
                          if (_passwordCheck.text == _password.text)
                            {_isSamePw = true}
                          else
                            {_isSamePw = false},
                        },
                    obscureText: true,
                    minLines: null,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      hintText: '비밀번호를 다시 한번 입력하세요',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                // 비밀번호 확인 컨테이너
                if (_isPwChecked) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '비밀번호를 다시 한번 입력해주세요',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
                SizedBox(height: 20),
                // ---------------------------------------회원가입 버튼-----------------------------------------
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, bool> invalidResult = Regist.invalidData(
                        _nick.text,
                        _password.text,
                        _email.text,
                      );

                      if (invalidResult[_nick.text] == false) {
                        makeSnackBar(context, "닉네임 형식이 올바르지 않습니다");
                        return;
                      }

                      if (invalidResult[_email.text] == false) {
                        makeSnackBar(context, "이메일 형식이 올바르지 않습니다");
                        return;
                      }

                      if (invalidResult[_password.text] == false) {
                        makeSnackBar(context, "비밀번호 형식이 올바르지 않습니다");
                        return;
                      }

                      if (!_isSamePw) {
                        makeSnackBar(context, "비밀번호가 일치하지 않습니다");
                        return;
                      }
                      Regist_API registerManager = Regist_API();
                      Map<String, dynamic> result = await registerManager
                          .register(
                            nick: _nick.text,
                            pw: _password.text,
                            email: _email.text,
                          );
                      if (result['success'] == false) {
                        makeSnackBar(
                          context,
                          ("회원가입 실패 원인: " + result["body"]),
                        );
                        return;
                      }

                      // 회원가입 성공한 경우
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                '회원가입이 완료되었습니다!',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          )
                          .closed
                          .then((_) {
                            _nick.clear();
                            _password.clear();
                            _passwordCheck.clear();
                            _email.clear();
                            Navigator.pushNamed(context, RoutePage.login);
                          });
                    },
                    child: Text(
                      '회원가입',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // ---------------------------------------SNS 연동--------------------------------------------
                Container(
                  width: 350,
                  child: TextDivider(
                    text: Text(
                      '또는',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    thickness: 2.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      'Google로 계속하기',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      '카카오톡으로 계속하기',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      '네이버로 계속하기',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      style: Theme.of(context).textTheme.labelLarge,
                      '인스타그램으로 계속하기',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '이미 계정이 있으신가요?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _nick.clear();
                          _password.clear();
                          _passwordCheck.clear();
                          Navigator.pushNamed(context, RoutePage.login);
                        },
                        child: Text(
                          '로그인',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
