import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import '/services/camera_service.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context){
    final cameraService = Provider.of<CameraService>(context);
    final controller = cameraService.controller;

    return Scaffold(
      appBar: AppBar(title: Text('카메라')),
      body: CameraPreview(controller),
    );
  }
}