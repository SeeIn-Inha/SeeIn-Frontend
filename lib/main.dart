import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seein_frontend/screens/select_home_screen.dart';
import 'services/auth_provider.dart';
import 'routes/router.dart';

// screen참고 testhome =영수증, product_analysis가 상품분석. select home임의로 만들어놓음.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providerManager = AuthProvider();
  await dotenv.load(fileName: ".env");
  await providerManager.loadToken();
  print("Token Loading Success");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: providerManager),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeeIn',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xFF8685EF),
        secondaryHeaderColor: Color(0xFFDEDCEE),
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
        cardColor: Color(0xFFFFFFFF),
        // font style set
        fontFamily: 'Pretendard',
        textTheme: TextTheme(
          // 폰트 크기, 색상, 굵기 스타일 지정
          displayMedium: TextStyle(
            fontSize: 52,
            color: Color(0xFF8685EF),
            fontWeight: FontWeight.w700,
          ),
          // 큰 제목
          headlineLarge: TextStyle(
            fontSize: 48,
            color: Color(0xFF8685EF),
            fontWeight: FontWeight.w700,
          ),
          //  페이지 제목
          titleLarge: TextStyle(
            fontSize: 26,
            color: Color(0xFF8685EF),
            fontWeight: FontWeight.w700,
          ),
          // 앱바 제목, 카드 제목 등
          titleMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          // 본문 제목
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          // 본문
          bodySmall: TextStyle(
            fontSize: 18,
            color: Color(0xFF8685EF),
            fontWeight: FontWeight.w400,
          ),
          // 설명, 부가 텍스트
          labelLarge: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          // 버튼 등 UI 텍스트
          labelSmall: TextStyle(
            fontSize: 16,
            color: Color(0xFF8685EF),
            fontWeight: FontWeight.w400,
          ), // 부가 텍스트
        ),
        // TextTheme Setting
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF8685EF),
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black,
            fixedSize: Size(300, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // ElevatedButtonTheme Setting
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF8685EF),
          foregroundColor: Color(0xFFDEDCEE),
        ), // AppBarTheme Setting
      ),
      initialRoute: RoutePage.start,
      routes: RoutePage.appRoutes,
    );
  }
}

class MainAppContext extends ChangeNotifier {}
