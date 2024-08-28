import 'package:flutter/material.dart';

import '../Variables/colors.dart';

class CustomImage extends StatelessWidget {
  final String file;
  final double width;
  final double height;
  final Color? bgColor;
  final double radius;
  final BoxFit imageFit;

  const CustomImage(
    this.file, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.bgColor,
    this.radius = 50,
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }

  _buildImage() {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: .1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: AssetImage(file),
              fit: imageFit,
            ),
          ),
        ),
      ],
    );
  }
}
