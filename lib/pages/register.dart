import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  final Function(String) setAuthLocation;

  RegisterPage({Key? key, 
    required this.title,
    required this.setAuthLocation
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
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
          child: const Text("Log in"),
          onPressed: () => {
            widget.setAuthLocation("login")
          }
        )
      ]
    );
  }
}