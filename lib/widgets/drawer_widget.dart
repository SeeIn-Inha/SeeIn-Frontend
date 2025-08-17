import 'package:flutter/material.dart';
import '../routes/router.dart';
import '../services/user_provider.dart';
import 'package:provider/provider.dart';
import '../config/appTheme.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;
    final theme = AppTheme.lightTheme;
    final UserProvider userManager = ctx.read<UserProvider>();

    String _username = "";
    String _email = "";

    if (userManager.username != null) {
      _username = userManager.username!;
    } else {
      _username = "비로그인 사용자";
    }
    if (userManager.email != null) {
      _email = userManager.email!;
    } else {
      _email = "Non-Email";
    }
    bool _isGuest = (_username == "비로그인 사용자" || _email == "Non-Email");

    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                )
              )
            ),
            height: h * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.06),
                  Icon(Icons.account_circle_outlined, size: w*0.15,),
                  SizedBox(height: h * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_username, style: theme.textTheme.bodyMedium,),
                      SizedBox(height: h * 0.001),
                      Text(_email, style: theme.textTheme.labelSmall,)
                    ],
                  ),
                  if (!_isGuest) ...[
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(ctx, RoutePage.myInfo);
                          },
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            fixedSize: MaterialStateProperty.all(Size(w * 0.3, h * 0.02)),
                          ),
                          child: Text(
                            '내 정보',
                            style: theme.textTheme.labelLarge,),
                        ),
                        SizedBox(width: w * 0.02,),
                        ElevatedButton(
                          onPressed: () {
                            userManager.clearUserData();
                            Navigator.pushReplacementNamed(ctx, RoutePage.start);
                          },
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            fixedSize: MaterialStateProperty.all(Size(w * 0.3, h * 0.02)),
                          ),
                          child: Text(
                            '로그아웃',
                            style: theme.textTheme.labelLarge,),
                        )
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ), // Header Container
          SizedBox(height: h * 0.05),
          ListTile(
            // Route to Home
            leading: Icon(Icons.home, size: w * 0.13),
            title: Text('홈', style: Theme.of(ctx).textTheme.titleMedium),
            onTap: () {
              // 홈으로 이동
              Navigator.pushReplacementNamed(ctx, RoutePage.home);
            },
          ),
          SizedBox(height: h * 0.03),
          ListTile(
            // Route to Camera
            leading: Icon(Icons.camera_alt_rounded, size: w * 0.13),
            title: Text('카메라', style: Theme.of(ctx).textTheme.titleMedium),
            onTap: () {
              // 앱 핵심 기능 카메라 페이지로 이동
              // 페이지 추후 개발
              Navigator.pop(ctx);
              if ((_email == "Non-Email" || _username == "비로그인 사용자") || (_email == "" || _username == "")) {
                ScaffoldMessenger.of(ctx)
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
                Navigator.pushReplacementNamed(ctx, RoutePage.home);
              }
            },
          ),
          SizedBox(height: h * 0.03),
          ListTile(
            leading: Icon(Icons.menu_book_outlined, size: w * 0.13),
            title: Text('사용 설명', style: Theme.of(ctx).textTheme.titleMedium),
            onTap: () {
              // 앱 사용 설명으로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(ctx, RoutePage.start);
            },
          ),
          SizedBox(height: h * 0.03),
          ListTile(
            // Route to Help
            leading: Icon(Icons.help, size: w * 0.13),
            title: Text('도움말', style: Theme.of(ctx).textTheme.titleMedium),
            onTap: () {
              // 도움말로 이동
              // 페이지 추후 개발
              Navigator.pushReplacementNamed(ctx, RoutePage.start);
            },
          ),
        ], // Children End
      ),
    ); // ListView for Drawer
  }
}