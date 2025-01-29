import 'package:attendance_app/ui/attend/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Padding buildCapturePhotoSection(BuildContext context, Size size, XFile? image) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Capture Photo",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen())
            );
          },
        )
      ],
    ),
  );
}