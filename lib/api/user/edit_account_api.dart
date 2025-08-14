import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class EditAccountApi {
  Future<bool> editAccount(String email, String username) async {
    Uri url = Uri.parse('$baseUrl/auth/edit');
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'email': email,
        'username': username
      })
    );

    if (res.statusCode != 200) {
      return false;
    }

    return true;
  }
}