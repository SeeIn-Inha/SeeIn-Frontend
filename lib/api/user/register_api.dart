import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class Regist_API {
  Future<Map<String, dynamic?>> register({
    required String username,
    required String pw,
    required String email,
  }) async {
    print("회원 가입 요청 테스트");
    final uri = Uri.parse('$baseUrl/auth/register');
    final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': pw,
          'username': username,
        })
    );

    Map<String, dynamic>? result = null;

    if (res.statusCode != 200) {
      result =
        ({
        'success': false,
        'body': '회원가입 실패',
        });
    } else {
      result =
        ({
        'success': true,
        'body': '회원가입 성공',
        });
    }

    return result;
  }

}