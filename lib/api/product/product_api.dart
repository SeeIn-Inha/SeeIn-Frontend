import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProductApiClient {
  //.env로 API_BASE_UR 관리. ipcconfig 사용해서 개별.
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

  /// 테스트용 자산 이미지로 분석 요청
  static Future<Map<String, dynamic>?> analyzeTestAssetImage() async {
    final uri = Uri.parse('$baseUrl/analyze-and-recommend-product-test/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  /// 추천 API 호출
  static Future<String?> fetchRecommendation({
    required String name,
    required String brand,
    required String summary,
  }) async {
    final uri = Uri.parse('$baseUrl/recommend-product/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'brand': brand,
        'summary': summary,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data['result'];
      }
    }
    return null;
  }
}





// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
//
// class ProductApiClient {
//   static const String baseUrl = "http://192.168.0.5:8000"; // 서버 주소 (실행 환경에 따라 IP 교체 필요 ipconfig)
//
//   /// ✅ 실제 서버로 상품 이미지 업로드 → 분석 + 추천 결과 반환
//   static Future<Map<String, dynamic>?> analyzeAndRecommend({required XFile image}) async {
//     final uri = Uri.parse('${dotenv.env['API_BASE_URL']}/analyze-and-recommend-product/');
//
//     final request = http.MultipartRequest('POST', uri);
//     request.files.add(await http.MultipartFile.fromPath('file', image.path));
//
//     try {
//       final response = await request.send();
//       final resBody = await response.stream.bytesToString();
//
//       if (response.statusCode == 200) {
//         final decoded = json.decode(resBody);
//         if (decoded['success'] == true) {
//           return decoded;
//         } else {
//           print('❌ 서버 처리 실패: ${decoded['error']}');
//         }
//       } else {
//         print('❌ 상태 코드: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('❌ 예외 발생: $e');
//     }
//
//     return null;
//   }
//
//   /// ✅ 테스트용 assets 이미지에 대한 더미 분석 결과 반환
//   static Future<Map<String, dynamic>> analyzeTestAssetImage() async {
//     await Future.delayed(const Duration(milliseconds: 500)); // 로딩 시뮬레이션
//
//     // 임시 더미 결과
//     return {
//       "success": true,
//       "product": {
//         "name": "테스트칩",
//         "brand": "샘플",
//         "summary": "예시 감자칩입니다."
//       },
//       "recommendation": "사지 말 것 같음"
//     };
//   }
// }
