import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

  Future<QuerySnapshot> getData() {
    // ini buat ambil semua data dari collection 'attendance' (database)
    // hasilnya nanti berupa QuerySnapshot, yg isinya kumpulan dokumen dari collection itu
    return dataCollection.get();
  }

  Future<void> deleteData(String docId) { // docId isinya itu id dokumen yg mau dihapus.
    return dataCollection.doc(docId).delete();
  }
}