import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  GradientButton({
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: this.onPressed == null
          ? [
              Colors.grey,
              const Color.fromARGB(255, 59, 59, 59),
            ]
          : [
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
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}