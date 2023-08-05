import 'package:flutter/material.dart';
import 'package:daginga_server_status/app/pages/home_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}