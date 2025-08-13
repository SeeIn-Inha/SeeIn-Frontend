import 'package:flutter/material.dart';
import '../routes/router.dart';
import '../services/user_provider.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userManager = context.read<UserProvider>();

    String _nickname = "";
    String _email = "";

    if (userManager.username != null) {
      _nickname = userManager.username!;
    } else {
      _nickname = "비로그인 사용자";
    }

    if (userManager.email != null) {
      _email = userManager.email!;
    } else {
      _email = "Non-Email";
    }

    bool _isGuest = (_nickname == "비로그인 사용자" || _email == "Non-Email");
    print("[로그인 사용자 상태 확인] - 사용자: ${_nickname}, 이메일: ${_email}, 로그인 여부: ${_isGuest}");
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          // alignment: Alignment.center,
          height: 250,
          color: Theme.of(context).primaryColor,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'SEE IN',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nickname,
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Text(
                        _email,
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  if (!_isGuest) ...[
                    SizedBox(width: 30),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, RoutePage.myInfo);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2F3A8F),
                            fixedSize: Size(110, 20),
                          ),
                          child: Text(
                            '내 정보',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // userManager.clearUserData();
                            // Navigator.pushReplacementNamed(context, RoutePage.start);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2F3A8F),
                            fixedSize: Size(110, 20),
                          ),
                          child: Text(
                            '로그아웃',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ), // Header Container
        ListTile(
          // Route to Home
          leading: Icon(Icons.home, size: 40),
          title: Text('홈', style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            // 홈으로 이동
            Navigator.pushReplacementNamed(context, RoutePage.home);
          },
        ),
        ListTile(
          // Route to Camera
          leading: Icon(Icons.camera_alt_rounded, size: 40),
          title: Text('카메라', style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            // 앱 핵심 기능 카메라 페이지로 이동
            // 페이지 추후 개발
            Navigator.pop(context);
            print("email: $_email          nickname: $_nickname");
            if ((_email == "Non-Email" || _nickname == "비로그인 사용자") ||
                (_email == "" || _nickname == "")) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      content: Text("로그인 후 이용하실 수 있습니다!"),
                      duration: Duration(seconds: 1),
                    ),
                  )
                  .closed
                  .then((_) {
                    // Navigator.pushReplacementNamed(context, RoutePage.start);
                  });
            } else {
              Navigator.pushReplacementNamed(context, RoutePage.home);
            }
          },
        ),
        ListTile(
          leading: Icon(Icons.menu_book_outlined, size: 40),
          title: Text('사용 설명', style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            // 앱 사용 설명으로 이동
            // 페이지 추후 개발
            Navigator.pushReplacementNamed(context, RoutePage.start);
          },
        ),
        ListTile(
          // Route to Help
          leading: Icon(Icons.help, size: 40),
          title: Text('도움말', style: Theme.of(context).textTheme.titleMedium),
          onTap: () {
            // 도움말로 이동
            // 페이지 추후 개발
            Navigator.pushReplacementNamed(context, RoutePage.start);
          },
        ),
      ], // Children End
    ); // ListView for Drawer
  }
}
