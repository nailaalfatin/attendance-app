import 'dart:math';
import 'package:attendance_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    enableTracking: true,
    enableLandmarks: true
  ));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      // rect in ituh biar proses absensi kita nih ga diboongin, jadi dia ngedetect apakah kita ini beneran 2d apa gambar(1d)
      final Rect boundingBox = face.boundingBox; //mengambil komponen dari gambar

      final double? verticalPosition = face.headEulerAngleY; //ini itu untuk menghandle posisi wajah secara vertikal
      final double? horizontalPosition = face.headEulerAngleZ; //ini itu untuk menghandle posisi wajah secara horizontal
      // Z di situ bukan sumbu horizontal kayak x di koordinat biasa, tapi lebih ke rotasi kemiringan kepala. 
      // kalo mau tau apakah seseorang beneran menghadap kamera atau gambar 2D doang, bisa dicek dari kombinasi Yaw & Roll.

      // perkondisian apabila face landmark sudah aktif, ditandai oleh (mulut, mata, pipi, hidung, dan telinga)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      if (leftEar != null) {
        final Point<int> leftEarPosition = leftEar.position; //kalo si telinganya terdeteksi, dia bakal return itu posisi telinganya itu
        print("Left Ear Position: $leftEarPosition");
      }

      // perkondisian apabila wajahnya terdeteksi (ditandai dengan bibir tersenyum)
      if (face.smilingProbability != null) {
        final double? smilingProbability = face.smilingProbability;
        print("Smile Probability: $smilingProbability");
      }

      // perkondisian apabila fitur tracking wajah sudah aktif
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    }
  }
}