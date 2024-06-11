import "dart:convert";
import 'package:flutter/material.dart';
import "package:gaskeun_mobile/api/auth.dart";
import "package:gaskeun_mobile/components/GradientButton.dart";

class RegisterPage extends StatefulWidget {
  final String title;
  final Function onSuccessAuth;
  final Function(String) onFailedAuth;

  RegisterPage({Key? key, 
    required this.title,
    required this.onSuccessAuth,
    required this.onFailedAuth
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    var requestCompleted = true;
    void toggleRequestCompleted() {
      setState(() {
        requestCompleted = !requestCompleted;
      });
    }

    bool isFilled(value) {
      return !(value.isEmpty || value == null);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget> [
          TextFormField(
            decoration: const InputDecoration( hintText: "Nama Lengkap"),
            controller: _fFullName,
            validator: (value) {
              if(!isFilled(value)) {
                return "This field has to be filled";
              }
              return null;
            }
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration( hintText: "Email anda"),
            controller: _fEmail,
            validator: (value) {
              if(!isFilled(value)) {
                return "This field has to be filled";
              }
              return null;
            }
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
            validator: (value) {
              if(!isFilled(value)) {
                return "This field has to be filled";
              } else if(value!.length < 8) {
                return "Password has to be at least 8 characters";
              }
              return null;
            }
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
            validator: (value) {
              if(!isFilled(value)) {
                return "This field has to be filled";
              }

              var hasMatchingPassword = _fPassword.text == _fConfirmPassword.text;
              if(!hasMatchingPassword) {
                return "Confirmation password should match with password";
              }

              return null;
            }
          ),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                final data = jsonEncode(<String, String> {
                  "nama": _fFullName.text,
                  "email": _fEmail.text,
                  "password": _fPassword.text,
                  "password_confirmation": _fConfirmPassword.text
                });
                APIAuth().register(data, widget.onSuccessAuth, widget.onFailedAuth);
              }
            }, 
            text: "Daftar"
          )
        ]
      )
    );
  }
}