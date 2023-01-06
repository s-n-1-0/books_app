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
          primarySwatch: const MaterialColor(0xff4d6a87, <int, Color>{
        50: Color(0xffeaedf1),
        100: Color(0xffcad2db),
        200: Color(0xffa6b5c3),
        300: Color(0xff8297ab),
        400: Color(0xff688099),
        500: Color(0xff4d6a87),
        600: Color(0xff46627f),
        700: Color(0xff3d5774),
        800: Color(0xff344d6a),
        900: Color(0xff253c57),
      })),
      home: const RootPage(),
    );
  }
}
