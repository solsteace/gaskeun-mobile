import 'package:flutter/material.dart';
import "pages/auth/main.dart";
import "components/carousel.dart";

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

  // TODO: persistent auth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showCarousel
            ? OnboardingCarousel(
          onFinish: () {
            setState(() {
              showCarousel = false;
            });
          },
        )
            : AuthPage(title: "Authenticated"),
      ),
    );
  }
}
