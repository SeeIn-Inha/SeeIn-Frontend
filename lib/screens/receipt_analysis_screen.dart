// C:\Seein\SeeIn-Frontend\lib\screens\recipt_analysis_screen.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seein_frontend/api/receipt/test_receipt_api.dart';
import 'package:seein_frontend/services/tts_service.dart'; // TtsService 임포트
import '../widgets/drawer_widget.dart';
import 'dart:convert';

// 클래스 이름을 파일 이름에 맞춰 'ReceiptAnalysisScreen'으로 변경합니다.
class ReceiptAnalysisScreen extends StatefulWidget {
  const ReceiptAnalysisScreen({super.key});

  @override
  State<ReceiptAnalysisScreen> createState() => _ReceiptAnalysisScreenState();
}

class _ReceiptAnalysisScreenState extends State<ReceiptAnalysisScreen> {
  // 영수증 분석 결과를 담을 변수. 초기 메시지를 설정합니다.

  String _receiptInfo = '영수증 정보를 분석하려면 버튼을 눌러주세요.';

  final ImagePicker _picker = ImagePicker();



// API 호출 중인지 여부를 나타내는 상태 변수

  bool _isLoading = false;



// TtsService 인스턴스

  final TtsService _ttsService = TtsService();



  /// 카메라로 영수증 사진을 촬영하고 분석을 요청하는 함수

  Future<void> _takePhotoAndAnalyze() async {

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);



    if (image != null) {

      await _analyzeImage(image);

    } else {

      _showSnackbar('사진 촬영이 취소되었습니다.');

    }

  }



  /// 갤러리에서 영수증 사진을 선택하고 분석을 요청하는 함수

  Future<void> _pickImageFromGalleryAndAnalyze() async {

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);



    if (image != null) {

      await _analyzeImage(image);

    } else {

      _showSnackbar('이미지 선택이 취소되었습니다.');

    }

  }



  /// 선택된 이미지를 백엔드 API로 보내 분석하고 결과를 처리하는 내부 함수

  Future<void> _analyzeImage(XFile image) async {

    setState(() {

      _receiptInfo = '영수증 분석 중... 잠시만 기다려 주세요.';

      _isLoading = true;

    });



// 백엔드 API 호출

    final result = await ReceiptApiClient.analyzeReceipt(image: image);



    if (result != null) {

// 성공적으로 정보를 받아왔을 때

      setState(() {

// 받아온 JSON Map을 '키: 값' 형태의 텍스트로 변환

        _receiptInfo = _formatJsonAsText(result);

        _isLoading = false;

      });

      _showSnackbar('영수증 분석 성공!');

      print('영수증 분석 성공: $result');

    } else {

// 분석 실패 시

      setState(() {

        _receiptInfo = '영수증 분석에 실패했습니다. 서버 로그를 확인해주세요.';

        _isLoading = false;

      });

      _showSnackbar('영수증 분석 실패!');

      print('영수증 분석 실패.');

    }

  }



  /// 사용자에게 메시지를 보여주는 스낵바 함수

  void _showSnackbar(String message) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(content: Text(message)),

    );

  }



  /// JSON (Map) 데이터를 '키: 값' 형태의 텍스트로 변환하는 재귀 함수

  String _formatJsonAsText(dynamic data, [String indent = '']) {

    StringBuffer buffer = StringBuffer();

    if (data is Map) {

// String으로 변환하여 타입 오류 해결

      List<String> keys = data.keys.map((key) => key.toString()).toList();

      for (int i = 0; i < keys.length; i++) {

        String key = keys[i];

        dynamic value = data[key];

        buffer.write('$indent$key: ');

        if (value is Map || value is List) {

          buffer.writeln();

          buffer.write(_formatJsonAsText(value, '$indent '));

        } else {

          buffer.writeln(value.toString());

        }

        if (i < keys.length - 1) {

          buffer.writeln(); // 마지막 항목이 아니면 줄바꿈 추가

        }

      }

    } else if (data is List) {

      for (var item in data) {

        buffer.writeln('$indent- '); // 리스트 항목 앞에 '- '를 추가하고 줄바꿈

        buffer.write(_formatJsonAsText(item, '$indent '));

      }

    } else {

      return data.toString();

    }

    return buffer.toString();

  }





  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFFAFAFF),

      appBar: AppBar(

        title: const Text('영수증 분석'),

        backgroundColor: const Color(0xFF9C89FF),

        foregroundColor: Colors.white,

      ),

      body: Padding(

        padding: const EdgeInsets.all(24.0),

        child: Column(

          children: <Widget>[

// 상단 버튼 영역

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [

                _buildActionButton(

                  icon: Icons.camera_alt,

                  label: '카메라 촬영',

                  onPressed: _isLoading ? null : _takePhotoAndAnalyze,

                ),

                _buildActionButton(

                  icon: Icons.photo_library,

                  label: '갤러리 선택',

                  onPressed: _isLoading ? null : _pickImageFromGalleryAndAnalyze,

                ),

              ],

            ),

            const SizedBox(height: 30),

            const Divider(thickness: 1.2),

            const SizedBox(height: 20),



// 결과 제목

            const Text(

              '분석 결과',

              style: TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 20),

// 결과 표시 영역

            Expanded(

              child: SingleChildScrollView(

                child: Card(

                  elevation: 3,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(12),

                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(20),

                    child: _isLoading

                        ? const Center(child: CircularProgressIndicator())

                        : Text(

                      _receiptInfo,

                      textAlign: TextAlign.start,

                      style: const TextStyle(

                        fontSize: 16,

                        fontFamily: 'monospace',

                        height: 1.4,

                      ),

                    ),

                  ),

                ),

              ),

            ),



// --- '음성 안내' 버튼 추가 ---

            if (_receiptInfo.isNotEmpty && _receiptInfo != '영수증 정보를 분석하려면 버튼을 눌러주세요.')

              Padding(

                padding: const EdgeInsets.only(bottom: 20.0),

                child: ElevatedButton.icon(

                  onPressed: () {

// TtsService의 speak 함수를 호출하기 전에 로그를 출력합니다.

                    print("TTS가 읽을 내용: $_receiptInfo");

                    _ttsService.speak(_receiptInfo);

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



  /// 첫 번째 코드와 동일한 스타일의 버튼 위젯

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