import 'package:flutter/material.dart';

class PageOnBG extends StatelessWidget {
  final List<Widget> children;

  PageOnBG({
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width
    final double height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    final screenHeight = height - padding.top - padding.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
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
              ),
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints( minHeight: screenHeight ),
                  child: IntrinsicHeight( // Force column to be as tall as all of its children
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: this.children,
                    ),
                  )
                )
              )
            ],
          )
        );
      }
    );
  }
}

