import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class Regist_API {
  Future<Map<String, dynamic?>> register({
    required String id,
    required String pw,
    required String email,
  }) async {
    final uri = Uri.parse('$baseUrl/auth/register');
    print(uri);
    final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': pw,
          'username': id,
        })
    );

    if (response.statusCode != 200) {
      return ({"success": false, "body": "잠시 후 다시 시도해 주세요"});
    }

    // final data = json.decode(response.body);
    return ({'success': true});
  }

}