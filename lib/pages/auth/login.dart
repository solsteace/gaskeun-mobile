import 'package:flutter/material.dart';
import "../../components/GradientButton.dart";

import "../carOrder/main.dart";
import "../../models/Car.dart";

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
          GradientButton(
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CarOrderPage(
                      car: Car(
                        id: 1, 
                        providerId: 1, 
                        carImageId: 1, 
                        capacity: 4, 
                        price: 300000, 
                        brand: "Toyota",
                        model: "Innova Zenix", 
                        description: "Deskripsi", 
                        status: "Tersedia", 
                        plateNumber: "E 3 JIR", 
                        transmission: "Manual", 
                        fuel: "Bensin"
                      )
                    )
                  )
                );
              }
            }, 
            text: "Masuk"
          ),
        ]
      )
    );
  }
}