import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_provider.dart';
import '../../widgets/common_widget.dart';
import '../../config/appTheme.dart';

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final UserProvider userManager = ctx.read<UserProvider>();
    final String email = userManager.email!;
    final String username = userManager.username!;

    final w = MediaQuery.of(ctx).size.width;
    final h = MediaQuery.of(ctx).size.height;
    final theme = AppTheme.lightTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: h * 0.2,),
              // 프로필 이미지
              Icon(Icons.account_circle, size: w * 0.4),
              SizedBox(height: 20),

              // 닉네임 / 이메일 카드
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: theme.secondaryHeaderColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('닉네임: $username', style: theme.textTheme.labelSmall),
                    Divider(color: theme.secondaryHeaderColor, thickness: 1.5),
                    Text('이메일: $email', style: theme.textTheme.labelSmall),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // 내 정보 수정 / 회원 탈퇴 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 내 정보 수정 스크린으로 이동
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(w * 0.4, h * 0.04),
                      backgroundColor: theme.scaffoldBackgroundColor,
                    ),
                    child: Text('내 정보 수정', style: theme.textTheme.labelSmall),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: ctx,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('회원 탈퇴 확인'),
                            content: Text('정말로 회원 탈퇴를 진행하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('아니오'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 회원 탈퇴 로직 추가 해야함
                                  final UserProvider userManager = ctx.read<UserProvider>();
                                  userManager.clearUserData();
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(ctx, '/start');
                                },
                                child: Text('예', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(w * 0.4, h * 0.04),
                      backgroundColor: theme.scaffoldBackgroundColor,
                    ),
                    child: Text('회원 탈퇴', style: theme.textTheme.labelSmall),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
