import 'package:camera/camera.dart';

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  // 카메라 초기화
  late CameraController controller;

  Future<void> cameraInit() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
  }

  // 카메라 서비스 로직
  void dispose(){
    controller.dispose();
  }
}

