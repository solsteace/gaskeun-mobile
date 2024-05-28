import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "../../components/GradientButton.dart";

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

  Widget _buildForm() {
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
            decoration: const InputDecoration(
              hintText: "Nama Lengkap"
            ),
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
            decoration: const InputDecoration(
              hintText: "Email anda"
            ),
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
                // toggleRequestCompleted();
                // showDialog<String>(
                //   context: context, 
                //   builder: (BuildContext context) => (
                //     AlertDialog(
                //       title: const Text("Please wait"),
                //       content: const Column(
                //         children: <Widget>[
                //           CircularProgressIndicator(),
                //           Text("Currently processing your data")
                //         ]
                //       ),
                //       actions: <Widget>[
                //         TextButton(
                //           onPressed: () {
                //             toggleRequestCompleted();
                //             return Navigator.pop(context, "Ok");
                //           }, 
                //           child: const Text("Ok")
                //         )
                //       ],
                //     )
                //   )
                // );
              }
            }, 
            text: "Daftar"
          ),
        ]
      ) ,
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
            SizedBox(height:10),
            SizedBox(
              height: 25, width: 100,
              child: Image(
                image: AssetImage("assets/img/logo-navbar.png")
              )
            )
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