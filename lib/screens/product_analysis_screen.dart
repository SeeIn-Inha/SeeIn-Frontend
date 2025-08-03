import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

///  상품 분석 및 추천 화면
/// - 이미지 업로드 → FastAPI 서버에서 상품 분석 및 요약 결과 받기
/// - 분석 결과 기반으로 '살까 말까' 추천까지 제공
class ProductAnalysisScreen extends StatefulWidget {
  const ProductAnalysisScreen({super.key});

  @override
  State<ProductAnalysisScreen> createState() => _ProductAnalysisScreenState();
}

class _ProductAnalysisScreenState extends State<ProductAnalysisScreen> {
  final ImagePicker _picker = ImagePicker();

  // 분석 결과 텍스트
  String _resultText = '아직 분석된 결과가 없습니다.';

  // 분석 완료 여부
  bool _isAnalyzed = false;

  ///  이미지 업로드 → 서버 분석 요청
  Future<void> _analyzeImageWithAPI(XFile image) async {
    setState(() {
      _resultText = '서버에 이미지 업로드 중...';
      _isAnalyzed = false;
    });

    final uri = Uri.parse('${dotenv.env['API_BASE_URL']}/analyze-and-recommend-product/');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200) {
        final data = json.decode(responseBody);
        if (data['success'] == true) {
          final product = data['product'];

          setState(() {
            _resultText = '''
✅ 분석 완료
상품명: ${product['name']}
브랜드: ${product['brand']}
요약: ${product['summary']}
''';
            _isAnalyzed = true;
          });

          _showSnackbar('상품 분석 성공!');
        } else {
          _setError('❌ 분석 실패: ${data['error']}');
        }
      } else {
        _setError('❌ 서버 오류: 상태 코드 ${streamedResponse.statusCode}');
      }
    } catch (e) {
      _setError('❌ 예외 발생: $e');
    }
  }

  ///  이미지 선택 (카메라 or 갤러리)
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) {
      _showSnackbar('이미지 선택이 취소되었습니다.');
      return;
    }

    await _analyzeImageWithAPI(pickedFile);
  }

  ///  추천 요청 → 분석된 상품 정보로 POST 요청
  Future<void> _fetchRecommendation(String name, String brand, String summary) async {
    final uri = Uri.parse('${dotenv.env['API_BASE_URL']}/recommend-product/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': name,
      'brand': brand,
      'summary': summary,
    });

    try {
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['result'];

        if (result != null) {
          setState(() {
            _resultText += '\n\n💡 추천 결과\n$result';
          });
        } else {
          _showSnackbar('추천 결과가 없습니다.');
        }
      } else {
        _showSnackbar('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackbar('추천 요청 중 예외 발생: $e');
    }
  }

  ///  분석 텍스트에서 상품명, 브랜드, 요약 추출 (정규식 기반)
  Map<String, String>? _extractProductInfo(String text) {
    final nameMatch = RegExp(r'상품명:\s(.+)').firstMatch(text);
    final brandMatch = RegExp(r'브랜드:\s(.+)').firstMatch(text);
    final summaryMatch = RegExp(r'요약:\s(.+)').firstMatch(text);

    if (nameMatch != null && brandMatch != null && summaryMatch != null) {
      return {
        'name': nameMatch.group(1)!.trim(),
        'brand': brandMatch.group(1)!.trim(),
        'summary': summaryMatch.group(1)!.trim(),
      };
    }

    return null;
  }

  ///  스낵바로 사용자에게 피드백 메시지 출력
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  ///  에러 메시지 세팅 + 스낵바 출력
  void _setError(String message) {
    setState(() {
      _resultText = message;
      _isAnalyzed = false;
    });
    _showSnackbar(message);
  }

  ///  UI 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 분석 및 추천')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 📷 이미지 선택 버튼 (카메라/갤러리)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text('갤러리에서 분석'),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('카메라 촬영'),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              '분석 결과',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 📋 결과 출력 영역
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _resultText,
                        style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                      ),
                      // 💡 분석이 완료된 경우에만 추천 버튼 표시
                      if (_isAnalyzed)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.help_outline),
                            label: const Text('살까 말까?'),
                            onPressed: () {
                              final productInfo = _extractProductInfo(_resultText);
                              if (productInfo != null) {
                                _fetchRecommendation(
                                  productInfo['name']!,
                                  productInfo['brand']!,
                                  productInfo['summary']!,
                                );
                              } else {
                                _showSnackbar('상품 정보를 찾을 수 없습니다.');
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
