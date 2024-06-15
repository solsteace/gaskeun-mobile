import 'package:flutter/material.dart';

class PageWithAppBar extends StatelessWidget {
  final String title;
  final List<Widget> children;

  PageWithAppBar({
    required this.title,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          this.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16
          )
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.children,
            )
          )
        )
      )
    );
  }
}

