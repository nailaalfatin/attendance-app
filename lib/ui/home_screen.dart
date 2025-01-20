import 'package:attendance_app/ui/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope( //makesure mau kembali atau enggak, takutnya ada data yg belum kesimpen
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: InkWell( //buat link yang bisa di klik
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const AttendanceScreen())
                      );
                    },
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage('/assets/images/ic_attend.png'),
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Attendance Report",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      barrierDismissible: false, //buat enggak bisa pas di pencet area selain box pop up notifnya
      context: context, 
      builder: (context) =>
        AlertDialog(
          title: const Text(
            "Information",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          content: const Text(
            "Do you want to exit?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //ini biar dia ga kemana mana dan pop up nya ilang
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
                ),
              )
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(), //ini buat keluar dari aplikasi 
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
                ),
              )
            )
          ],
        )
      )
    );
  }
}