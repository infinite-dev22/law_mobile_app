import 'package:flutter/material.dart';

class NoDocumentsWidget extends StatelessWidget {
  const NoDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No documents available now"),
    );
  }
}
