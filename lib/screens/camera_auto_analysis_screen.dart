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

    final result = await ReceiptApiClient.analyzeReceipt(image: photo);

    setState(() {
      _loading = false;
      _result = result?.toString() ?? "❌ 분석 실패";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFF),
      appBar: AppBar(
        title: const Text("영수증 자동 분석"),
        backgroundColor: const Color(0xFF9C89FF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _captureAndAnalyze,
              icon: const Icon(Icons.camera_alt),
              label: const Text("📸 촬영 후 자동 분석"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C89FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.2),
            const SizedBox(height: 20),
            const Text(
              "분석 결과",
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
                    child: Text(
                      _result,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
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
