import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 사진 촬영/선택을 위한 패키지
import 'package:seein_frontend/api/receipt/test_receipt_api.dart'; // API 클라이언트 임포트
import 'dart:convert'; // JSON 인코딩/디코딩을 위해 필요 (받아온 Map을 문자열로 표시하기 위함)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _receiptInfo = '영수증 정보를 분석하려면 버튼을 눌러주세요.';
  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스 생성

  /// 카메라로 영수증 사진을 촬영하고 분석을 요청하는 함수
  Future<void> _takePhotoAndAnalyze() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera); // 카메라로 사진 촬영

    if (image != null) {
      await _analyzeImage(image);
    } else {
      _showSnackbar('사진 촬영이 취소되었습니다.');
    }
  }

  /// 갤러리에서 영수증 사진을 선택하고 분석을 요청하는 함수
  Future<void> _pickImageFromGalleryAndAnalyze() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // 갤러리에서 사진 선택

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
    });

    // 백엔드 API 호출
    final result = await ReceiptApiClient.analyzeReceipt(image: image);

    if (result != null) {
      // 성공적으로 정보를 받아왔을 때
      setState(() {
        // 받아온 JSON Map을 보기 좋게 들여쓰기된 문자열로 변환
        _receiptInfo = '분석 완료:\n${JsonEncoder.withIndent('  ').convert(result)}';
      });
      _showSnackbar('영수증 분석 성공!');
      print('영수증 분석 성공: $result');
    } else {
      // 분석 실패 시
      setState(() {
        _receiptInfo = '영수증 분석에 실패했습니다. 서버 로그를 확인해주세요.';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영수증 분석 앱'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _takePhotoAndAnalyze,
                icon: const Icon(Icons.camera_alt),
                label: const Text('카메라로 영수증 촬영'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImageFromGalleryAndAnalyze,
                icon: const Icon(Icons.photo_library),
                label: const Text('갤러리에서 영수증 선택'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '분석 결과:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      _receiptInfo,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}