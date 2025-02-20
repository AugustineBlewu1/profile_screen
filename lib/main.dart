import 'package:flutter/material.dart';
import 'package:profile_screen/src/screens/bottom_nav.dart';
import 'package:profile_screen/src/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, primary: primarColor),
        useMaterial3: true,
      ),
      
      home: const BottomNav(),
    );
  }
}
