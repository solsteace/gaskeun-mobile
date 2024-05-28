import 'package:flutter/material.dart';
import "../../layouts/pageOnBG.dart";
import "./login.dart";
import "./register.dart";

class AuthPage extends StatefulWidget {
  final String title;
  AuthPage({Key? key, required this.title}) : super(key: key);

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
                    setAuthLocation: _setAuthLocation,
                  )
                : RegisterPage(
                    title: "register", 
                    setAuthLocation: _setAuthLocation,
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
}