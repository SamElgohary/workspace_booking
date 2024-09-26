import 'package:flutter/material.dart';
import 'package:workspace_booking/utlis/colors.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const BottomButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width - 32, // Equivalent to ScreenSize.width(context) - 32
      decoration: BoxDecoration(
        color: primaryColor, // Replace with `primaryColor` if needed
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        border: Border.all(
          color: Colors.blueGrey,
          width: 2.0,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
