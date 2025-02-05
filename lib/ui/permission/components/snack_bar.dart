import 'package:flutter/material.dart';

class SnackBarComponent {
  // static model --> untuk mempertahankan value dari function yang di panggil
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) { //ini tuh sama aja kaya required {bool isError = false}
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          )
        ],
      )
    ));
  }
}