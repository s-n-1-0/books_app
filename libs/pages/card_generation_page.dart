import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../components/book_card.dart';
import '../components/elevated_gradation_Button.dart';
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
  bool isThumbnail = true;
  ProcessingStatus saveStatus = ProcessingStatus.unprocessed;
  ProcessingStatus shareStatus = ProcessingStatus.unprocessed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildAfterGeneration() +
                      [
                        ElevatedButton(
                          child: const Text("画像を再生成"),
                          onPressed: () async {
                            makeImage(0);
                          },
                        ),
                        //サムネイルURLがそもそも存在しないならオプションを表示しない
                        if (widget.bookData.coverUrl != "")
                          SwitchListTile(
                            title: const Text('サムネイルを表示'),
                            value: isThumbnail,
                            onChanged: ((newVal) {
                              setState(() {
                                isThumbnail = newVal;
                              });
                              makeImage(0);
                            }),
                            secondary: const Icon(Icons.image_rounded),
                          )
                      ],
                ))));
  }

  List<Widget> buildAfterGeneration() {
    if (_bytes == null) return [];
    return [
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
      ElevatedGradationButton(
          onPressed: () async {
            //ダブルクリック防止
            if (false &&
                _bytes != null &&
                saveStatus != ProcessingStatus.processing) {
              setState(() {
                saveStatus = ProcessingStatus.processing;
              });
              // await ImageGallerySaver.saveImage(_bytes!);
              setState(() {
                saveStatus = ProcessingStatus.processed;
              });
            }
          },
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.purple],
          ),
          child: RichText(
            text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.save_alt),
                ),
                TextSpan(
                    text: 'アルバムに保存',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          )),
      if (saveStatus == ProcessingStatus.processed)
        Text(
          "保存しました",
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      const SizedBox(height: 15),
      const Text("または"),
      const SizedBox(height: 15),
      ElevatedGradationButton(
          onPressed: () async {
            //ダブルクリック防止
            if (_bytes != null && shareStatus != ProcessingStatus.processing) {
              setState(() {
                shareStatus = ProcessingStatus.processing;
              });
              //共有シートを開いてる時にもう一度呼ぶとクラッシュする
              try {
                await Share.shareXFiles(
                    [XFile.fromData(_bytes!, mimeType: 'image/png')]);
              } catch (err) {}
              setState(() {
                shareStatus = ProcessingStatus.processed;
              });
            }
          },
          gradient: const LinearGradient(
            colors: [
              Colors.purple,
              Colors.redAccent,
            ],
          ),
          child: RichText(
            text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.ios_share),
                ),
                TextSpan(
                    text: 'カードを共有',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          )),
      const SizedBox(height: 35.0),
      if (_bytes != null) const Divider(),
    ];
  }

  void makeImage(int waitSeconds) async {
    _bytes = await BookCard(widget.bookData, isThumbnail: isThumbnail)
        .toImage(const Size(1200, 630), Duration(seconds: waitSeconds));
    setState(() {});
  }
}

enum ProcessingStatus { unprocessed, processing, processed }
