import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../components/book_card.dart';
import '../utils/widget2image.dart';

class CardGenerationPage extends StatefulWidget {
  const CardGenerationPage({super.key});
  @override
  State<StatefulWidget> createState() => _CardGenerationPageState();
}

class _CardGenerationPageState extends State<StatefulWidget> {
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ElevatedButton(
          child: const Text('画像化'),
          onPressed: () async {
            bytes = await const BookCard().toImage(const Size(1280, 720));
            setState(() {});
          },
        ),
        const Text("↓生成"),
        if (bytes != null)
          Container(
            padding: const EdgeInsets.all(32),
            width: double.infinity,
            height: 500,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Image.memory(bytes!.buffer.asUint8List())),
          )
      ],
    ));
  }
}
