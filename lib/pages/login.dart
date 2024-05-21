import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  final Function(String) setAuthLocation;

  LoginPage({Key? key, 
    required this.title,
    required this.setAuthLocation
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        Text("Lorem"),
        TextButton(
          child: const Text("Register"),
          onPressed: () => {
            widget.setAuthLocation("register")
          }
        )
      ]
    );
  }
}