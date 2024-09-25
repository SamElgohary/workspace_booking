import 'package:flutter/material.dart';

class IconAndTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final TextStyle textStyle;

  const IconAndTextRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black26, // Default icon color
    this.textStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 2),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
