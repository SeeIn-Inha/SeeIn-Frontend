import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/drawer_widget.dart';
import 'package:text_divider/text_divider.dart';
import '../../api/user/login_api.dart';
import '../../services/auth_provider.dart';
import '../../routes/router.dart';
import '../../api/user/fetch_my_info.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pw = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final FocusNode _pwFocus = FocusNode();

  bool _pwFocused = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    _pwFocus.addListener(() {
      setState(() {
        _pwFocused = _pwFocus.hasFocus;
      });
    });

  }

  @override
  void dispose() {
    _pwFocus.dispose();
    super.dispose();
  }

  void makeSnackBar(BuildContext context, String target) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            target,
            style: Theme.of(context).textTheme.bodyMedium,),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD:lib/screens/login_page.dart
    final mainState = Provider.of<MainAppContext>(context);
=======
    final mainState = Provider.of<AuthProvider>(context);
>>>>>>> e21ca0b (feat: 일반 로그인):lib/screens/login_screen.dart

    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: Menu(),
        ),
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
                        IconButton( // 뒤로 가기 버튼
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),),
                        Text(
                          '로그인',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),  // 뒤로 가기 버튼 컨테이너
                  SizedBox(height: 10),
                  // ----------------------------------------------이메일-------------------------------------------
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      '이메일',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 2),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      minLines: null,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                        hintText: '이메일을 입력하세요',
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
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      '비밀번호',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),  // 비밀번호 레이블
                  // ------------------------------------------비밀번호-----------------------------------------------------
                  SizedBox(height: 2),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      controller: _pw,
                      minLines: null,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력하세요',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 1, color: Color(0xFF4B4737)),
                        ),
                      ),
                    ),
                  ),  // 비밀번호 입력 컨테이너
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = !(_isChecked);
                            });
                          },
                        ),
                        SizedBox(width: 1),
                        Text(
                            style: Theme.of(context).textTheme.bodyMedium,
                            '자동 로그인'
                        ),
                      ],
                    ),
                  ),  // 자동 로그인 컨테이너 영역
                  // ---------------------------------------로그인----------------------------------------------
                  Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          final authManager = context.read<AuthProvider>();

                          if (authManager.isTokenValid) { // 유효 토큰 시에 홈 화면 이동
                            print("유효 토큰");
                            Navigator.pushReplacementNamed(context, RoutePage.home);
                          } else {
                            print("토큰 기간 만료");
                            authManager.clearToken();
                          }

                          Login_API loginManager = Login_API();
                          Map<String, dynamic> result = await loginManager.login(email: _email.text, pw: _pw.text);

                          if (result["success"] == false) {
                            makeSnackBar(context, result["body"]);
                            return;
                          }

                          print(result["access_token"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('', style: Theme.of(context).textTheme.bodyLarge),
                                duration: Duration(seconds: 2),
                              )
                          ).closed
                              .then((_) async {
                            _pw.clear();
                            _email.clear();
                            // JWT 토큰 저장 및 홈 화면 이동
                            // await authManager.saveToken(result["access_token"], result["expire"]);
                            await authManager.saveToken(result["access_token"]);
                            FetchMyInfo_API myInfoAPI = FetchMyInfo_API();
                            await myInfoAPI.fetchMyInfo(context);
                            Navigator.pushReplacementNamed(context, RoutePage.home);
                          });
                        },
                        child: Text(
                          style: Theme.of(context).textTheme.labelLarge,
                          '로그인',
                        ),
                      )
                  ),  // 로그인 버튼 컨테이너
                  SizedBox(height: 15),
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
                          onPressed: () {

                          },
                          child: Text(
                              style: Theme.of(context).textTheme.labelLarge,
                              'Google로 계속하기'
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(
                              style: Theme.of(context).textTheme.labelLarge,
                              '카카오톡으로 계속하기'
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(
                              style: Theme.of(context).textTheme.labelLarge,
                              '네이버로 계속하기'
                          )
                      )
                  ),
                  SizedBox(height: 10),
                  Container(
                      child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(
                              style: Theme.of(context).textTheme.labelLarge,
                              '인스타그램으로 계속하기'
                          )
                      )
                  ),
                ],
              ),
            )
        )
    );
  }
}