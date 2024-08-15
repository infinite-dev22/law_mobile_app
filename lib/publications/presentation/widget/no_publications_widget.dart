import 'package:flutter/material.dart';

class NoPublicationsWidget extends StatelessWidget {
  const NoPublicationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No publications available now"),
    );
  }
}
