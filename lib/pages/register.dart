import 'package:flutter/material.dart';
import "../components/GradientButton.dart";

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
  final _fFullName = TextEditingController();
  final _fEmail = TextEditingController();
  final _fPassword = TextEditingController();
  final _fConfirmPassword = TextEditingController();


  var _passwordHidden = true;
  void _toggleHidePassword() {
    setState(() { 
      _passwordHidden = !_passwordHidden; 
    });
  }

  var _confirmPasswordHidden = true;
  void _toggleHideConfirmPassword() {
    setState(() { 
      _confirmPasswordHidden = !_confirmPasswordHidden; 
    });
  }

  Widget _buildForm() {
    return Column(
      children: <Widget> [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Nama Lengkap"
          ),
          controller: _fFullName
        ),
        const SizedBox(height: 20),
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
        TextFormField(
          obscureText: _confirmPasswordHidden,
          decoration: InputDecoration(
            hintText: "Konfirmasi Password",
            suffixIcon: IconButton(
              onPressed: _toggleHideConfirmPassword,
              icon: Icon(_confirmPasswordHidden? Icons.visibility: Icons.visibility_off)
            )
          ),
          controller: _fConfirmPassword,
        ),
        const SizedBox(height: 20),
        GradientButton(
          onPressed: () {
          }, 
          text: "Daftar"
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
          "Isilah formulir di bawah ini untuk kemudahan akses ke semua fitur yang kami tawarkan",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400
          ),
        ),
        _buildForm(), 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sudah punya akun?"),
            TextButton(
              child: const Text("Log in"),
              onPressed: () => {
                widget.setAuthLocation("login")
              }
            )
          ],
        )
      ]
    );
  }
}