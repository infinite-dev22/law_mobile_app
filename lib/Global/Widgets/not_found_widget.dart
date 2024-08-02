import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text(
            "40",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text("Not Found"),
        ],
      ),
    );
  }
}
