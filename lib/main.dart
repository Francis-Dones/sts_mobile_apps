import 'package:flutter/material.dart';
import 'package:sts_mobile_apps/View/login.dart';
import 'package:sts_mobile_apps/View/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    Color.fromARGB(255, 85, 4, 236);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'title',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 2, 23, 120),
      ),
      home: const Homepage(title: 'title'),
    );
  }
}

void signOut() {}
