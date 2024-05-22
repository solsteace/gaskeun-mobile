import 'package:flutter/material.dart';
import "../pages/login.dart";
import "../pages/register.dart";

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                 Color(0xFFFFBCFF),
                 Color(0xFF0117FF),
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 50,
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
                padding: new EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 44,
                ),
                width: double.infinity,
                child: ( _authLocation == "login"
                  ? LoginPage(
                      title: "login", 
                      setAuthLocation: _setAuthLocation,
                    )
                  : RegisterPage(
                      title: "register", 
                      setAuthLocation: _setAuthLocation,
                    )
                )
              )
            ],
          )
        )
      )
    );
  }
}