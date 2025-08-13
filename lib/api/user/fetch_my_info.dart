import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../services/user_provider.dart';
import '../../routes/router.dart';
import '../../config/appTheme.dart';
import '../../widgets/common_widget.dart';
// 로그인 성공 시, 내 정보 불러오기
final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class FetchMyInfo_API {
  Future<void> fetchMyInfo(BuildContext ctx) async {
    final AuthProvider authManager = ctx.read<AuthProvider>();

    final Uri uri = Uri.parse('$baseUrl/auth/me');
    final res = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${authManager.token}',
      }
    );

    Map<String, dynamic> data;
    if (res.statusCode != 200) {
      final CommonWidget widgetMaker = CommonWidget();
      widgetMaker.buildSnackBar(ctx, "토큰이 유효하지 않습니다", AppTheme.lightTheme);
      Navigator.pushReplacementNamed(ctx, RoutePage.start);
    } else {
      data = json.decode(res.body);
      ctx.read<UserProvider>().setUserData(data);
    }
  }
}