import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seein_frontend/services/tts_service.dart';
import '../widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;

class ProductAnalysisScreen extends StatefulWidget {
  final XFile? image;

  const ProductAnalysisScreen({super.key, this.image});

  @override
  State<ProductAnalysisScreen> createState() => _ProductAnalysisScreenState();
}

class _ProductAnalysisScreenState extends State<ProductAnalysisScreen> {
  final ImagePicker _picker = ImagePicker();
  final TtsService _ttsService = TtsService();

  String _resultText = '아직 분석된 결과가 없습니다.';
  String _ttsText = '';
  bool _isAnalyzed = false;

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      _analyzeImageWithAPI(widget.image!);
    }
  }

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

          final screenText = '''
✅ 분석 완료
상품명: ${product['name']}
브랜드: ${product['brand']}
요약: ${product['summary']}
''';
          final ttsText = '분석 완료. 상품명: ${product['name']}. 브랜드: ${product['brand']}. 요약: ${product['summary']}.';

          setState(() {
            _resultText = screenText;
            _ttsText = ttsText;
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

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) {
      _showSnackbar('이미지 선택이 취소되었습니다.');
      return;
    }

    await _analyzeImageWithAPI(pickedFile);
  }

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
            _ttsText += '추천 결과: $result.';
          });
          _ttsService.speak('추천 결과가 도착했습니다. $result');
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

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _setError(String message) {
    setState(() {
      _resultText = message;
      _isAnalyzed = false;
    });
    _showSnackbar(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFF),
      appBar: AppBar(
        title: const Text('상품 분석 및 추천'),
        backgroundColor: const Color(0xFF9C89FF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.image,
                  label: '갤러리에서 분석',
                  onPressed: _isAnalyzed ? null : () => _pickImage(ImageSource.gallery),
                ),
                _buildActionButton(
                  icon: Icons.camera_alt,
                  label: '카메라 촬영',
                  onPressed: _isAnalyzed ? null : () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.2),
            const SizedBox(height: 20),
            const Text(
              '분석 결과',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _resultText,
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ),
                        if (_isAnalyzed)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.help_outline),
                                label: const Text('살까 말까?'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9C89FF),
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
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
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // --- '음성 안내' 버튼 추가 ---
            if (_isAnalyzed)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // _ttsService 인스턴스를 통해 음성 안내를 실행합니다.
                    _ttsService.speak(_ttsText);
                  },
                  icon: const Icon(Icons.volume_up),
                  label: const Text('음성 안내'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ? Colors.grey : const Color(0xFF9C89FF),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
    );
  }
}