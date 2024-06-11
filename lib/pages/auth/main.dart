import 'package:flutter/material.dart';
import "../../layouts/pageOnBG.dart";
import "./login.dart";
import "./register.dart";
import "package:gaskeun_mobile/pages/home/main.dart";

class AuthPage extends StatefulWidget {
  final String title;
  AuthPage({
    Key? key, 
    required this.title,
  }) : super(key: key);

  @override 
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  String _authLocation = "login";

  void _setAuthLocation(newLocation) {
    setState(() {
      _authLocation = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageOnBG(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Hallo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                _authLocation == "login"
                  ? "Masuk ke Akun Anda"
                  : "Buat Akun Anda",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(
            left: 25, right: 25,
            top: 40, bottom: 10
          ),
          width: double.infinity,
          child:  Column(
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
              Text(
                (_authLocation == "login"
                  ? "Masukkan email dan password Anda untuk mendapatkan akses semua fitur kami"
                  : "Isilah formulir di bawah ini untuk kemudahan akses ke semua fitur yang kami tawarkan"
                ),
                style: const TextStyle( fontSize: 13, fontWeight: FontWeight.w400),
              ),
              ( _authLocation == "login"
                ? LoginPage(
                    title: "login", 
                    onSuccessAuth: () {
                      _onSuccessAuth("Login success", () { // TODO store logged user data!
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(title: "Home", user: 1))
                        );
                      });
                    },
                    onFailedAuth: _showErrorDialog
                  )
                : RegisterPage(
                    title: "register", 
                    onSuccessAuth: () {
                      _onSuccessAuth("Register success", () {
                        _setAuthLocation("login");
                      });
                    },
                    onFailedAuth: _showErrorDialog
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (_authLocation == "login"
                  ? [
                      const Text("Belum punya akun?"),
                      TextButton(
                        child: const Text("Register"),
                        onPressed: () => _setAuthLocation("register")
                      )
                    ]
                  : [
                      const Text("Sudah punya akun?"),
                      TextButton(
                        child: const Text("Log in"),
                        onPressed: () => _setAuthLocation("login")
                      )
                    ]
                )
              )
            ],
          )
        )
      ],
    );
  }

void _onSuccessAuth(String message, Function callback) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () { 
              Navigator.pop(context, 'OK'); 
              callback();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
}

void _showErrorDialog(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}