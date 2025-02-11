import 'package:attendance_app/services/data_service.dart';
import 'package:attendance_app/ui/history/components/attendance_card.dart';
import 'package:attendance_app/ui/history/components/delete_dialog.dart';
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
      body: StreamBuilder( //buat mempertahankan ui dan widget kita biar widget kita termanage well karna kan disini udah ada interaksi dengan db
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
              return AttendanceHistoryCard(
                data: data[index].data() as Map<String, dynamic>, //untuk mendefinisikan data yg akan muncul di ui berdasarkan index/posisi yang ada di db
                onDelete: () {
                  showDialog(
                    context: context, 
                    builder: (context) => DeleteDialog(
                      // untuk mejadikan index sebagai id dari data yang di db
                      documentId: data[index].id, 
                      dataCollection: dataService.dataCollection, 
                      // digunakan untuk memperbarui state setelah terjadi penghapusan dari db
                      onConfirm: () { 
                       setState(() {
                         dataService.deleteData(data[index].id);
                         Navigator.pop(context);
                       });
                      },
                    )
                  );
                }
              );
            }
          );
        }
      ),
    );
  }
}