import "dart:convert";
import 'package:flutter/material.dart';
import "package:gaskeun_mobile/api/auth.dart";
import "package:gaskeun_mobile/components/GradientButton.dart";

class LoginPage extends StatefulWidget {
  final String title;
  final Function(int, String, String, String, String) onSuccessAuth;
  final Function(String) onFailedAuth;

  LoginPage({Key? key, 
    required this.title,
    required this.onSuccessAuth,
    required this.onFailedAuth
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _fEmail = TextEditingController();
  final _fPassword = TextEditingController();
  
  var _passwordHidden = true;

  void _toggleHidePassword() {
    setState(() { 
      _passwordHidden = !_passwordHidden; 
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
              }
              return null;
            }
          ),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                final data = jsonEncode(<String, String> {
                  "email": _fEmail.text,
                  "password": _fPassword.text
                });
                APIAuth().login(data, widget.onSuccessAuth, widget.onFailedAuth);
              }
            } , 
            text: "Masuk"
          ),
        ]
      )
    );
  }
}