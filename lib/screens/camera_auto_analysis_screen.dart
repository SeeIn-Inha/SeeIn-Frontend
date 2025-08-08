import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seein_frontend/api/receipt/test_receipt_api.dart'; // FastAPI 호출 클라이언트

class CameraAutoAnalysisScreen extends StatefulWidget {
  const CameraAutoAnalysisScreen({super.key});

  @override
  State<CameraAutoAnalysisScreen> createState() => _CameraAutoAnalysisScreenState();
}

class _CameraAutoAnalysisScreenState extends State<CameraAutoAnalysisScreen> {
  final ImagePicker _picker = ImagePicker();
  String _result = "📸 버튼을 눌러 촬영을 시작하세요.";
  bool _loading = false;

  /// 📸 카메라 촬영 후 자동 분석
  Future<void> _captureAndAnalyze() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo == null) {
      setState(() => _result = "촬영이 취소되었습니다.");
      return;
    }

    setState(() {
      _loading = true;
      _result = "서버에 분석 요청 중...";
    });

    // 분석 요청 (압축 없이 바로)
    final result = await ReceiptApiClient.analyzeReceipt(image: photo);

    setState(() {
      _loading = false;
      _result = result?.toString() ?? "❌ 분석 실패";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("카메라 촬영 자동 분석")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _captureAndAnalyze,
              icon: const Icon(Icons.camera_alt),
              label: const Text("📸 촬영 후 자동 분석"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
