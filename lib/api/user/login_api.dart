import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class Login_API {
  Future<Map<String, dynamic?>> login(
      {required email, required pw}) async {
    final Uri uri = Uri.parse('$baseUrl/auth/login');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "email": email,
        "password": pw,
      }
      )
    );

    Map<String, dynamic>? result = json.decode(res.body);

    if (res.statusCode != 200) {
      return ({'success': false, 'body': '회원가입 실패',});
     }

    return result!;
  }
}