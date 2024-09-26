import 'package:flutter/material.dart';

class AvailabilityLine extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  // Constructor that allows passing color, width, and height
  const AvailabilityLine({
    Key? key,
    required this.color,
    this.width = 40.0, // default width
    this.height = 2.0, // default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
