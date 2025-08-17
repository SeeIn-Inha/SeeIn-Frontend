import 'package:flutter/material.dart';
import '../routes/router.dart';

// 초기 화면
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset('assets/icons/SEE-IN-Logo-rmbg.png', width: 100, height: 100,),
              // SizedBox(height: 10),
              Text(
                  'SEE IN',
                  style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 5),
              Text('시각장애인을 위한 스마트 정보 읽기 앱',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 30),
                ),
                onPressed: () {
                  // 로그인 화면 전환
                  Navigator.pushNamed(context, RoutePage.login);
                },
                child: Text('로그인', style: Theme.of(context).textTheme.labelLarge,),
              ),
              SizedBox(height: 8,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 30),
                ),
                onPressed: () {
                  // 회원 가입 화면 전환
                  Navigator.pushNamed(context, RoutePage.join);
                },
                child: Text('회원가입', style: Theme.of(context).textTheme.labelLarge,),
              ),
              SizedBox(height: 12),
              Text(
                '카메라로 제품이나 영수증을 촬영하면',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '음성으로 정보를 읽어드립니다',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}