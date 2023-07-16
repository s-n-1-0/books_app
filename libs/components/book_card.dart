import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Container(
          width: 1280,
          height: 720,
          alignment: Alignment.center,
          color: Colors.blue,
          child: const Text(
            "Test Card",
            style: TextStyle(fontSize: 120),
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
