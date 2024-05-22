import 'package:flutter/material.dart';

class Layout1 extends StatelessWidget {
  final List<Widget> children;

  Layout1({
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                 Color(0xFFFFBCFF),
                 Color(0xFF0117FF),
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.children,
          )
        )
      )
    );
  }
}

