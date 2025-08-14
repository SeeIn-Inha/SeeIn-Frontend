import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

class DeleteAccount {
  Future<bool> deleteAccount(String token, String email, String username) async {
    final Uri url = Uri.parse('$baseUrl/auth/delete_account');

    final res = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
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