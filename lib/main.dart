import 'package:flutter/material.dart';
import 'package:seein_frontend/screens/test_home_screen.dart'; // HomeScreen 임포트

void main() {
  // Flutter 앱이 실행되기 전에 필요한 초기화 작업을 수행합니다.
  // 예를 들어, Firebase 초기화나 특정 서비스 바인딩 등이 필요할 때 사용합니다.
  // 여기서는 특별한 작업이 없지만, 관례상 넣어두는 것이 좋습니다.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeeIn 영수증 분석 앱', // 앱 제목 변경
      theme: ThemeData(
        // 앱의 전체적인 테마를 설정합니다.
        // Material 3 디자인 시스템을 사용하도록 설정했습니다.
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent), // 앱의 기본 색상 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent, // 앱바 배경색
          foregroundColor: Colors.white,      // 앱바 텍스트/아이콘 색상
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // 버튼 배경색
            foregroundColor: Colors.white,      // 버튼 텍스트색
            textStyle: const TextStyle(fontWeight: FontWeight.bold), // 버튼 텍스트 스타일
          ),
        ),
      ),
      home: const HomeScreen(), // 앱의 시작 화면을 HomeScreen으로 설정합니다.
      // 이제 카운터 앱 대신 영수증 분석 화면이 나타납니다.
    );
  }
}