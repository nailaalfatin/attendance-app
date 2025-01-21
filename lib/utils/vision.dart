import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Vision {
  Vision._(); //dibuat jadi privat, biar ga bisa sembarang dipake, karna ini kan bakal dipake buat face detection

  static final Vision instance = Vision._();

  FaceDetector faceDetector([FaceDetectorOptions? option]) {
    return FaceDetector(options: option ?? FaceDetectorOptions());
  }
}