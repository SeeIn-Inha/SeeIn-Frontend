import 'package:flutter/material.dart';
import 'package:seein_frontend/screens/users/reset_password_screen.dart';
import '../screens/start_screen.dart';
import '../screens/users/join_screen.dart';
import '../screens/users/login_screen.dart';
import '../screens/camera_auto_analysis_screen.dart';
import '../screens/select_home_screen.dart';
import '../screens/users/my_info_screen.dart';
import '../screens/home_screen.dart';
import '../screens/test_home_screen.dart';
import '../screens/users/edit_profile_screen.dart';

// 화면 전환 라우팅 등록
class RoutePage {
  static const String start = '/';
  static const String home = '/home';
  static const String camera = '/camera';
  static const String join = '/join';
  static const String login = '/login';
  static const String select = '/select';
  static const String myInfo = '/myInfo';
  static const String realHome = '/realHome';
  static const String receipt = '/receipt';
  static const String editProfile = '/eiditProfile';
  static const String resetPassword = '/resetPassword';

  // screens/...
  static final Map<String, WidgetBuilder> appRoutes = {
    start: (context) => StartScreen(),
    home: (context) => SelectHomeScreen(),
    camera: (context) => CameraAutoAnalysisScreen(),
    join: (context) => JoinPage(),
    login: (context) => LoginPage(),
    myInfo: (context) => MyInfo(),
    realHome: (context) => Home(),
    receipt: (context) => HomeScreen(),
    editProfile: (context) => EditProfileScreen(),
    resetPassword: (context) => ResetPassword(),
  };
}