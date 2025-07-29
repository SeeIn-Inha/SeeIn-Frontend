import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/camera_service.dart';
import 'routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플랫폼(ios, and)과 flutter의 통신 안정성을 위해 정적 바인딩
  final cameraService = CameraService();
  await cameraService.cameraInit();

  runApp(MainApp(cameraService: cameraService));
}

class MainApp extends StatelessWidget {
  final CameraService cameraService;
  const MainApp({super.key, required this.cameraService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainAppContext()),
        Provider<CameraService>.value(value: cameraService),
      ],
      child: MaterialApp(
        title: 'SeeIn App',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Color(0xFFB5AB87),            // Light Beige
          secondaryHeaderColor: Color(0xFF4B4737),    // Dark Olive
          scaffoldBackgroundColor: Color(0xFFFFF8E1), // Cream Beige
          cardColor: Color(0xFFFFFFFF),
          // font style set
          fontFamily: 'Pretendard',
          textTheme: TextTheme( // 폰트 크기, 색상, 굵기 스타일 지정
            displayMedium: TextStyle(fontSize: 45, color: Color(0xFF4B4737), fontWeight: FontWeight.w700),  // 큰 제목
            headlineLarge: TextStyle(fontSize: 32, color: Color(0xFF4B4737), fontWeight: FontWeight.w700), //  페이지 제목
            titleLarge: TextStyle(fontSize: 22, color: Color(0xFF4B4737), fontWeight: FontWeight.w700),   // 앱바 제목, 카드 제목 등
            titleMedium: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500), // 본문 제목
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400), // 본문
            bodySmall: TextStyle(fontSize: 12, color: Color(0xFF4B4737), fontWeight: FontWeight.w400),  // 설명, 부가 텍스트
            labelLarge: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700), // 버튼 등 UI 텍스트
            labelSmall: TextStyle(fontSize: 11, color: Color(0xFF4B4737), fontWeight: FontWeight.w400), // 부가 텍스트
          ),  // TextTheme Setting
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4B4737),     // Dark Olive
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
          ),  // ElevatedButtonTheme Setting
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFFFF8E1),
            foregroundColor: Color(0xFF4B4737),
          ),  // AppBarTheme Setting
        ),
        initialRoute: RoutePage.home,
        routes: RoutePage.appRoutes,
      )
    );
  }
}

class MainAppContext extends ChangeNotifier {

}