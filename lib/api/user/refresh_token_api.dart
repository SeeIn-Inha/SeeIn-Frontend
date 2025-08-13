import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../services/auth_provider.dart';
import '../../widgets/common_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../routes/router.dart';
import '../../config/appTheme.dart';

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class RefreshToken {
  Future<void> refeshToken(BuildContext ctx, String email, String pw) async {
    final Uri uri = Uri.parse('$baseUrl/auth/refresh');
    final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': pw,
        })
    );

    if (res.statusCode != 200) {
      // 실패 시 스낵바
      final CommonWidget widgetMaker = CommonWidget();
      widgetMaker.buildSnackBar(ctx, "토큰 재발급에 실패하였습니다", AppTheme.lightTheme);
      Navigator.pushReplacementNamed(ctx, RoutePage.start);
      return;
    }

    Map<String, dynamic> result = json.decode(res.body);
    await ctx.read<AuthProvider>().saveToken(result['access_token']);
  }
}