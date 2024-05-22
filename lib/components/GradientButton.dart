import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  GradientButton({
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
              Color(0xFFFFBCFF),
              Color(0xFF0117FF),
          ]
        )
      ),
      child: ElevatedButton(
        onPressed: this.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent
        ),
        child: Text(
          this.text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}