import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../components/book_card.dart';
import '../utils/widget2image.dart';

class CardGenerationPage extends StatefulWidget {
  const CardGenerationPage({super.key, required this.bookData});
  final BookCardData bookData;
  @override
  State<StatefulWidget> createState() => _CardGenerationPageState();
}

class _CardGenerationPageState extends State<CardGenerationPage> {
  @override
  void initState() {
    super.initState();
    makeImage(3);
  }

  Uint8List? _bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_bytes != null)
              LayoutBuilder(builder: (context, size) {
                return ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 500),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      width: double.infinity,
                      height: size.maxWidth / 1.775,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.memory(_bytes!.buffer.asUint8List())),
                    ));
              }),
            if (_bytes != null)
              FloatingActionButton(
                onPressed: () {
                  if (_bytes != null) {
                    Share.shareXFiles(
                        [XFile.fromData(_bytes!, mimeType: 'image/png')]);
                  }
                },
                child: const Icon(Icons.save_alt),
                backgroundColor: Colors.red,
              ),
            const SizedBox(height: 35.0),
            ElevatedButton(
              child: const Text("画像を再生成"),
              onPressed: () async {
                makeImage(0);
              },
            )
          ],
        )));
  }

  void makeImage(int waitSeconds) async {
    _bytes = await BookCard(widget.bookData)
        .toImage(const Size(1200, 630), Duration(seconds: waitSeconds));
    setState(() {});
  }
}
