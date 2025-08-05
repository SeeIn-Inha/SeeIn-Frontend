import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _initTts(); //초기 설정
  }

  // 초기 설정 함수
  void _initTts() async {
    await _flutterTts.setLanguage("ko-KR"); // 한국어
    await _flutterTts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"}); // 한국어 여성 음성
    await _flutterTts.setSpeechRate(0.5);   // 말하는 속도 (0.0 ~ 1.0)
    await _flutterTts.setPitch(1.0);        // 목소리 톤 (0.5 ~ 2.0)
    await _flutterTts.setVolume(1.0);       // 볼륨 (0.0 ~ 1.0)
  }

  /* 언어 설정 setLanguage
  한국어 = "ko-KR"
  일본어 = "ja-JP"
  영어 = "en-US"
  중국어 = "zh-CN"
  */

  /* 음성 설정 setVoice
	영어 여성 {"name": "en-us-x-tpf-local", "locale": "en-US"}
  일본어 여성 {"name": "ja-JP-language", "locale": "ja-JP"}
  중국어 여성 {"name": "cmn-cn-x-ccc-local", "locale": "zh-CN"}
  중국어 남성 {"name": "cmn-cn-x-ccd-local", "locale": "zh-CN"}
  */

  // TTS iOS 옵션
  Future<void> initTtsIosOnly() async {
    // iOS 전용 옵션 : 공유 오디오 인스턴스 설정
    await _flutterTts.setSharedInstance(true);

    // 배경 음악와 인앱 오디오 세션을 동시에 사용
    await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);
  }


  // 텍스트 읽기 함수
  Future<void> speak(String text) async {
    if (text.trim().isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  // 음성 중지
  Future<void> stop() async {
    await _flutterTts.stop();
  }

  // 언어 설정 (예: "en-US", "ko-KR")
  Future<void> setLanguage(String langCode) async {
    await _flutterTts.setLanguage(langCode);
  }

  // 속도 설정 (0.0 ~ 1.0)
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  // 음 높이 설정 (0.5 ~ 2.0)
  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  // 볼륨 설정 (0.0 ~ 1.0)
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }
}


