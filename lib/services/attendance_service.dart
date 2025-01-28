import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ini itu entry point buat submitting the attendance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

Future<void> submitAttendanceReport(BuildContext context, String address, String name, String attendanceStatus, String timeStamp) async {
  showLoaderDialog(context);
  dataCollection.add(
    {
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
              Text(
                "Attendance submitted successfully",
                style: TextStyle(color: Colors.white),
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
    } catch (e) { //ini adalah kode kalo dia tuh salah atau error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.info,
                color: Colors.red,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Ups, $e",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          backgroundColor: Colors.orangeAccent,
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        )
      );
    }
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
    barrierDismissible: false, 
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}