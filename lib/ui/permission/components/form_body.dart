import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //TODO: MAKE UR OWN FORM BODY CONTENT
            "FORM BODY CONTENT"
          )
        ],
      ),
    );
  }
}