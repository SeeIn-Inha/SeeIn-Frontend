import 'package:flutter/material.dart';
import '../routes/router.dart';
import '../widgets/drawer_widget.dart';
import '../services/auth_provider.dart';
import '../services/user_provider.dart';
import 'package:provider/provider.dart';
import '../config/appTheme.dart';

// 초기 화면
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar( // 여기에 AppBar 위젯을 추가하세요.
          title: Text('홈페이지'),
          backgroundColor: Colors.blue,
          // 필요한 다른 속성들을 여기에 추가할 수 있습니다.
        ),
        body: _buildVerticalLayout(context, w, h, theme)
    );
  }

  Widget _buildVerticalLayout(BuildContext context, double w, double h, ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.08),
        child: Column(
          children: [
            Text('SEE IN', style: theme.textTheme.displayMedium),
            SizedBox(height: h * 0.01),
            Text('시각장애인을 위한 스마트 정보 읽기 앱', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
            SizedBox(height: h * 0.02),
            _buildButton(context, '로그인', w, theme),
            SizedBox(height: h * 0.012),
            _buildButton(context, '회원가입', w, theme),
            SizedBox(height: h * 0.02),
            Text('카메라로 제품이나 영수증을 촬영하면', style: theme.textTheme.bodyMedium),
            Text('음성으로 정보를 읽어드립니다', style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, double width, ThemeData theme) {
    return SizedBox(
      width: width < 600 ? width * 0.8 : width,
      child: ElevatedButton(
        onPressed: () {
          if (label == "로그인") {
            Navigator.pushNamed(context, RoutePage.login);
          } else {
            Navigator.pushNamed(context, RoutePage.join);
          }
        },
        style: theme.elevatedButtonTheme.style,
        child: Text(label, style: theme.textTheme.labelLarge),
      ),
    );
  }
}