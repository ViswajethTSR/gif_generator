import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gif_generator/screen/abbis_screen.dart';
import 'package:gif_generator/screen/gif_generator.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: AnimatedSplashScreen(
        splash: SplashScreen(),
        nextScreen: const MainApp(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        centered: true,
        backgroundColor: Colors.blue.shade200,
        splashIconSize: 200,
        duration: 3000,
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gif generator"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const GifGenerator(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.gif,
          size: 100,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          "GIF Generator",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
