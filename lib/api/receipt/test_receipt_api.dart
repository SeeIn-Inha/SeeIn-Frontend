import 'dart:convert'; // JSON 인코딩/디코딩을 위해 필요
import 'dart:io';    // File 클래스를 위해 필요 (XFile.path에서 File 객체 생성 시 사용될 수 있음)
import 'package:http/http.dart' as http; // HTTP 요청을 위해 필요
import 'package:image_picker/image_picker.dart'; // XFile 타입을 위해 필요

// 로컬에서 테스트 중이라면 'http://10.0.2.2:8000' (안드로이드 에뮬레이터) 또는 'http://localhost:8000' (iOS 시뮬레이터, 웹, 실제 기기)
// 실제 서버에 배포했다면 해당 서버의 공인 IP나 도메인 주소를 입력해야 합니다.
const String _baseUrl = 'http://10.0.2.2:8000'; // <<--- 이 부분을 실제 서버 IP 또는 'localhost'로 변경

class ReceiptApiClient {
  /// 영수증 이미지를 백엔드 API로 전송하고 분석된 정보를 받아옵니다.
  ///
  /// [image] 사용자가 선택하거나 촬영한 영수증 이미지 파일 (XFile 타입).
  ///
  /// Returns:
  /// 영수증 분석 결과가 담긴 Map<String, dynamic> 객체.
  /// 실패 시 null을 반환합니다.
  static Future<Map<String, dynamic>?> analyzeReceipt({required XFile image}) async {
    final uri = Uri.parse('$_baseUrl/analyze-receipt/'); // 영수증 분석 API 엔드포인트

    // MultipartRequest 생성: 파일과 함께 데이터를 전송할 때 사용합니다.
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'image', // 백엔드 FastAPI에서 `image: UploadFile = File(...)`의 'image'와 이름이 동일해야 합니다.
        image.path,
        // contentType: MediaType('image', 'jpeg'), // 필요시 이미지 타입 지정 (자동 감지될 때도 많음)
      ));

    try {
      // 요청 전송
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // HTTP 응답 상태 코드 확인
      if (response.statusCode == 200) {
        // 성공 시, 응답 본문을 JSON으로 디코딩하여 반환
        return json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      } else {
        // 오류 발생 시, 상태 코드와 메시지 출력
        print('API 호출 실패: 상태 코드 ${response.statusCode}');
        print('오류 내용: ${utf8.decode(response.bodyBytes)}'); // 오류 메시지를 한글 깨짐 없이 출력
        return null;
      }
    } catch (e) {
      // 네트워크 오류 등 예외 처리
      print('HTTP 요청 중 예외 발생: $e');
      return null;
    }
  }
}
