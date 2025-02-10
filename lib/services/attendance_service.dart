import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ini itu entry point buat submitting the attendance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance'); // 'attendance' itu unique key / collection yg bakal nyimpen data absen

Future<void> submitAttendanceReport(BuildContext context, String address, String name, String attendanceStatus, String timeStamp) async {
  showLoaderDialog(context);
  dataCollection.add(
    { // ini buat tambah data baru ke collection attendance, datanya dikirim dalam bentuk JSON dengan key-value
      'address' : address,
      'name' : name,
      'description' : attendanceStatus,
      'time' : timeStamp
    }
  ).then((result) {
    Navigator.of(context).pop();
    try { //ini adalah kode kalo dia tuh udah bener
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle_outline, 
                color: Colors.white
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Attendance submitted successfully",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          backgroundColor: Colors.orangeAccent,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        )
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    } catch (e) { //ini adalah kode kalo dia tuh salah atau ada data yg invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.info,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Text(
                "Ups, $e",
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          backgroundColor: Colors.blueAccent,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        )
      );
    }
  }).catchError((error) { //ini buat handle error yg general, misalnya kalau koneksi internet mati atau Firestore lagi down
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Ups, $error",
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        backgroundColor: Colors.blueAccent,
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
      )
    );
    Navigator.of(context).pop();
  });
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator( //ini buat loading indcator
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text("Checking the data.."),
        )
      ],
    ),
  );

  showDialog(
    barrierDismissible: false, // biar user gabisa nutup pop-up sebelum proses selesai
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}