import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) { // maksudnya disini tuh kameranya ada(bekeja)
      controller = CameraController(
        cameras![0], //berarti ini tuh bukan camera depan, bukan camera belakang
        // [0] itu buat camera belakang
        // [1] itu buat camera depan
        ResolutionPreset.high // atur resolusi kamera
      );
      await controller!.initialize();
    }
  }

  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      // aksi apabila kondisi bernilai negatif
      return const Center(child: CircularProgressIndicator());
    }
    // aksi apabila kondisi bernilai positif
    return CameraPreview(controller!);
  }
}