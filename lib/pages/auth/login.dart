import 'package:flutter/material.dart';
import "../../components/GradientButton.dart";

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
  final _fEmail = TextEditingController();
  final _fPassword = TextEditingController();
  
  var _passwordHidden = true;

  void _toggleHidePassword() {
    setState(() { 
      _passwordHidden = !_passwordHidden; 
    });
  }

  Widget _buildForm() {
    return Column(
      children: <Widget> [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Email anda"
          ),
          controller: _fEmail
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: _passwordHidden,
          decoration: InputDecoration(
            hintText: "Password anda",
            suffixIcon: IconButton(
              onPressed: _toggleHidePassword,
              icon: Icon(_passwordHidden? Icons.visibility: Icons.visibility_off)
            )
          ),
          controller: _fPassword,
        ),
        const SizedBox(height: 20),
        GradientButton(
          onPressed: () {
          }, 
          text: "Masuk"
        ),
      ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Selamat Datang di",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
            ),
            Text("Gaskeun"), // Change this into logo later
          ],
        ),
        const SizedBox(height: 60),
        const Text(
          "Masukkan email dan password Anda untuk mendapatkan akses semua fitur kami",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400
          ),
        ),
        _buildForm(), 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Belum punya akun?"),
            TextButton(
              child: const Text("Register"),
              onPressed: () => {
                widget.setAuthLocation("register")
              }
            )
          ],
        )
      ]
    );
  }
}