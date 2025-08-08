import 'package:flutter/material.dart';
import '../screens/start_screen.dart';
import '../screens/join_screen.dart';
import '../screens/login_screen.dart';
import '../screens/camera_auto_analysis_screen.dart';
import '../screens/select_home_screen.dart';

// 화면 전환 라우팅 등록
class RoutePage {
  static const String start = '/';
  static const String home = '/home';
  static const String camera = '/camera';
  static const String join = '/join';
  static const String login = '/login';

  // screens/...
  static final Map<String, WidgetBuilder> appRoutes = {
    start: (context) => StartScreen(),
    home: (context) => SelectHomeScreen(),
    camera: (context) => CameraAutoAnalysisScreen(),
    join: (context) => JoinPage(),
    login: (context) => LoginPage(),
  };
}