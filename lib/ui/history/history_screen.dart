import 'package:attendance_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance History"),
      ),
      body: StreamBuilder( //biar widget kita termanage well
        stream: dataService.dataCollection.snapshots(), // snapshots() itu buat memberitahukan si ui kalo datanya ini siap dipake
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No Data"),
            );
          }
          final data = snapshot.data!.docs; // docs adalah representasi dari semua data yang ada di FirebaseFirestore
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              // put attendance card
            }
          );
        }
      ),
    );
  }
}