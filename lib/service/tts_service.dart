import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  // TtsService가 앱 전체에서 단일 인스턴스로 사용되도록 수정
  static final TtsService _instance = TtsService._internal();
  factory TtsService() {
    return _instance;
  }
  TtsService._internal();

  // tts 인스턴스 생성
  final FlutterTts _flutterTts = FlutterTts();
  // OCR 결과를 저장할 리스트 추가
  List<String> _ocrResults = [];

  // 기본 설정으로 초기화 (앱 시작 시 한 번 호출하기)
  Future<void> init() async {
    await _flutterTts.setLanguage("ko-KR"); // 한국어로 설정
    await _flutterTts.setVoice({
      "name": "ko-kr-x-ism-local",
      "locale": "ko-KR"
    }); // 한국어 여성 음성
    await _flutterTts.setSpeechRate(0.5);   // 말하는 속도 (0.0 ~ 1.0)
    await _flutterTts.setPitch(1.0);        // 목소리 톤(음높이) (0.5 ~ 2.0)
    await _flutterTts.setVolume(1.0);       // 볼륨 (0.0 ~ 1.0)
  }


  /*IOS 전용 초기 설정*/
  Future<void> initTtsIosOnly() async {
    // iOS 전용 옵션 : 공유 오디오 인스턴스 설정
    await _flutterTts.setSharedInstance(true);

    // 배경 음악와 인앱 오디오 세션을 동시에 사용
    await _flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );
  }

  // 텍스트 읽기
  Future<void> speak(String text) async {
    if (text.trim().isNotEmpty) {
      await _flutterTts.stop(); // 기존 음성 중지
      await _flutterTts.speak(text);
    }
  }

  // 음성 중지
  Future<void> stop() async {
    await _flutterTts.stop();
  }

  // OCR 결과 저장 함수
  void setOcrResults(List<String> results) {
    _ocrResults = results; // OCR에서 인식한 텍스트들을 저장
  }

  // OCR 결과를 읽어주는 함수
  Future<void> readOcrResults() async {
    if (_ocrResults.isEmpty) {
      // OCR 결과가 없으면 안내 멘트
      await speak("아직 분석된 결과가 없습니다.");
      return;
    }

    // 각 줄을 읽기 전에 한국어 음성으로 명시적 설정
    for (var line in _ocrResults) {
      await _flutterTts.setLanguage("ko-KR");
      await _flutterTts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"});
      await speak(line);
      await Future.delayed(const Duration(milliseconds: 800)); // 문장 간 텀
    }
  }


  /* 음성 설정 setVoice
	영어 여성 {"name": "en-us-x-tpf-local", "locale": "en-US"}
  일본어 여성 {"name": "ja-JP-language", "locale": "ja-JP"}
  중국어 여성 {"name": "cmn-cn-x-ccc-local", "locale": "zh-CN"}
  중국어 남성 {"name": "cmn-cn-x-ccd-local", "locale": "zh-CN"}
  */
  Future<void> setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
  }

  /* 언어 설정 setLanguage
  한국어 = "ko-KR"
  일본어 = "ja-JP"
  영어 = "en-US"
  중국어 = "zh-CN"
  */
  Future<void> setLanguage(String langCode) async {
    await _flutterTts.setLanguage(langCode);
  }

  // 말하기 속도 설정 (0.0 ~ 1.0)
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  // 음높이 설정 (0.5 ~ 2.0)
  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  // 볼륨 설정 (0.0 ~ 1.0)
  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }
}