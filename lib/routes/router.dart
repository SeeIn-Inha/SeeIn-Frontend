import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/camera_page.dart';
import '../screens/join_page.dart';
import '../screens/login_page.dart';

// 화면 전환 라우팅 등록
class RoutePage {
  static const String home = '/';
  static const String camera = '/camera';
  static const String join = '/join';
  static const String login = '/login';

  // screens/...
  static final Map<String, WidgetBuilder> appRoutes = {
    home: (context) => HomePage(),
    camera: (context) => CameraPage(),
    join: (context) => JoinPage(),
    login: (context) => LoginPage(),
  };
}