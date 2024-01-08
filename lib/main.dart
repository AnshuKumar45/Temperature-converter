import 'dart:async';

import 'package:flutter/material.dart';
import 'package:temperature_converter/ConverterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(milliseconds: 2000),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ConverterScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              elevation: 15,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1.3, color: Colors.grey)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "assets/images/temp_conv.jpg",
                height: 150,
                width: 150,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Temperature",
            style: TextStyle(
                color: Colors.orange.shade900,
                fontSize: 28,
                fontWeight: FontWeight.w400),
          ),
          Text("Converter", style: TextStyle(color: Colors.blue, fontSize: 24))
        ],
      ),
    );
  }
}
