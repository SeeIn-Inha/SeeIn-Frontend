import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../services/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../services/user_provider.dart';
// 로그인 성공 시, 내 정보 불러오기
final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class FetchMyInfo_API {
  Future<void> fetchMyInfo(BuildContext context) async {
    final AuthProvider authManager = context.read<AuthProvider>();
    // 유효 기간을 서버에서 넘겨주지 않고 있기 때문에 아직은 토큰 유효성 검사를 내부에서 진행할 수 없음
    // String? token = null;
    //
    // if (authManager.isTokenValid) {
    //   token = authManager.token;
    // }
    //
    // if (token == null) {
    //   print("토큰 만료");
    //   return;
    // }
    final Uri uri = Uri.parse('$baseUrl/auth');
    final res = await http.post(
      uri,
      headers: {'Authorization': 'Bearer ${authManager.token}'},
    );

    Map<String, dynamic>? data = null;
    if (res.statusCode == 200) {
      data = json.decode(res.body);
      context.read<UserProvider>().setUserData(data); // << 사용자 정보 관리 로직
    } else {
      print("토큰이 만료되었거나 권한이 없음");
    }
  }
}