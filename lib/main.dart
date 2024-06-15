import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:gaskeun_mobile/pages/home/main.dart";
import "pages/auth/main.dart";
import "components/carousel.dart";
import "models/Profile.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showCarousel = true;
  bool userLogged = false;
  User loggedUser = User(id: -1, nama: "No user", email: "-", role: "-", token: "-");

  @override
  void initState() {
    super.initState();
  }

  void _setLoggedUser(int id, String name, String email, String role, String token) {
    setState(() { 
      loggedUser = User(id: id, nama: name, email: email, role: role, token: token); 
      userLogged = !(loggedUser.id == -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (showCarousel && !userLogged)
            ? OnboardingCarousel(
              onFinish: () {
                setState(() {
                  showCarousel = false;
                });
              },
            )
            : (userLogged
              ? HomePage(title: "homepage", user: loggedUser, index: 0)
              : AuthPage(title: "Authenticated", setLoggedUser: _setLoggedUser,)
            ),
      ),
    );
  }
}
