import 'package:flutter/material.dart';
import 'pages/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Books',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xff4d6a87)),
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}
