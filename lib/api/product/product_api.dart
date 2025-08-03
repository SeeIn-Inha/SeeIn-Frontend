import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

///  상품 분석 및 추천 API 클라이언트
/// - FastAPI 백엔드와 통신하여 상품 요약 및 추천 결과를 받아옴
/// - .env에 정의된 API 주소를 기반으로 서버 요청 수행
class ProductApiClient {
  //  .env에 정의된 BASE_URL 사용 (없으면 localhost fallback)
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';

  ///  테스트용 API 호출
  /// 서버에 요청을 보내고 더미 이미지 분석 결과를 받아옴
  /// (주로 개발 초기 UI 테스트 용도)
  static Future<Map<String, dynamic>?> analyzeTestAssetImage() async {
    final uri = Uri.parse('$baseUrl/analyze-and-recommend-product-test/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // JSON 문자열 → Map 형태로 디코딩
      return json.decode(response.body);
    }

    // 실패 시 null 반환
    return null;
  }

  ///  상품 추천 결과 요청
  /// 분석된 상품 정보(name, brand, summary)를 FastAPI 서버에 전달
  /// 서버에서 추천 결과 문자열을 반환
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
      // 서버에서 성공 여부 확인
      if (data['success'] == true) {
        return data['result']; // 추천 문장 반환
      }
    }

    // 실패 시 null 반환
    return null;
  }
}
