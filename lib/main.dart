import 'package:attendance_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  // jadi kalo make layanan dari firebase harus pake initializeApp() dulu, buat ngenalin
  // menambahkan firebase ke aplikasi kita
    options: const FirebaseOptions(
      // data ini semua di ambil dari google-services.json
      apiKey: "AIzaSyDEGqgSOL_LzmShfZf9fuBhlmv00kdpnNY", //current_key
      appId: "1:913300038355:android:814e8bc39fd3c595242a26", //mobilesdk_app_id
      messagingSenderId: "913300038355", //project_number
      projectId: "attendance-app-e8a9e" //project_id
    )
  ); 
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardTheme: const CardTheme(surfaceTintColor: Colors.white,),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}