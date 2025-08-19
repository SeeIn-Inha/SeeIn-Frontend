import 'package:flutter/material.dart';
import 'package:seein_frontend/screens/product_analysis_screen.dart';
import 'package:seein_frontend/screens/receipt_analysis_screen.dart'; // HomeScreen 정의된 곳

class SelectHomeScreen extends StatelessWidget {
  const SelectHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 제목
              const Text(
                'SEE IN',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C89FF),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '시각장애인을 위한 스마트 정보 읽기 앱',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),

              // 상품 분석 버튼
              SizedBox(
                width: 240,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('상품 분석 및 추천'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C89FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProductAnalysisScreen()),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // 영수증 분석 버튼
              SizedBox(
                width: 240,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('영수증 분석'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ReceiptAnalysisScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
