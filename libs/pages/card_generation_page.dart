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
  Uint8List? _bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  child: const Text('画像化'),
                  onPressed: () async {
                    _bytes = await BookCard(widget.bookData)
                        .toImage(const Size(1200, 630));
                    setState(() {});
                  },
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_bytes != null) {
                      Share.shareXFiles(
                          [XFile.fromData(_bytes!, mimeType: 'image/png')]);
                    }
                  },
                  child: Icon(Icons.save_alt),
                  backgroundColor: Colors.red,
                )
              ],
            ),
            const Text("↓生成"),
            if (_bytes != null)
              Container(
                padding: const EdgeInsets.all(32),
                width: double.infinity,
                height: 500,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.memory(_bytes!.buffer.asUint8List())),
              )
          ],
        )));
  }
}
