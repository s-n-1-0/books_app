import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/web.dart';

class BookCardData extends BaseBookData {
  BookCardData(
      {required this.title,
      required String isbn,
      required this.author,
      required this.coverUrl,
      //以下二つはQR用URL生成に使用
      String from = "",
      String comment = ""})
      : super(isbn: isbn, from: from, comment: comment);
  final String title, author, coverUrl;
}

final sampleBookCardData = BookCardData(
    title: "Docker&仮想サーバー完全入門　Webクリエイター＆エンジニアの作業がはかどる開発環境構築ガイド",
    isbn: "9780123456789",
    author: "オーキド",
    coverUrl: "https://cover.openbd.jp/9784295015314.jpg");

//TODO: サムネイル無しレイアウトも考える必要がある。
class BookCard extends StatelessWidget {
  const BookCard(this.data, {super.key});
  final BookCardData data;
  @override
  Widget build(BuildContext context) {
    double titleFontSizeFor2Lines = 40;
    double titleFontSizeFor1Line = 75;
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/mid_card_bg.png"),
                fit: BoxFit.fill,
              )),
          child: DefaultTextStyle(
              style: const TextStyle(color: Colors.black, fontSize: 35),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(55, 15, 55, 15),
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          if (data.coverUrl != "")
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 15, 25, 15),
                                child: Image.network(
                                  data.coverUrl,
                                  fit: BoxFit.contain,
                                  height: double.infinity,
                                )),
                          Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                const Spacer(),
                                LayoutBuilder(builder: (context, size) {
                                  int maxLines = 2;
                                  double fontSize = titleFontSizeFor2Lines;
                                  if (getTextLinesLength(
                                              data.title,
                                              TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: fontSize),
                                              maxLines,
                                              size.maxWidth) ==
                                          1 &&
                                      getTextLinesLength(
                                              data.title,
                                              TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      titleFontSizeFor1Line),
                                              maxLines,
                                              size.maxWidth) ==
                                          1) {
                                    fontSize = titleFontSizeFor1Line;
                                  }
                                  return Text(
                                    data.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: maxLines,
                                  );
                                }),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 100, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          data.author,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    )),
                                const Spacer(),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 150, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(data.isbn,
                                            textAlign: TextAlign.right)
                                      ],
                                    ))
                              ]))
                        ],
                      ))))),
      QrImage(
        data: data.getBookDataUrl(),
        version: QrVersions.auto,
        size: 200.0,
        foregroundColor: CustomColors.app,
        backgroundColor: Colors.white,
      )
    ]);
  }

  int getTextLinesLength(
      String text, TextStyle style, int maxLines, double maxWidth) {
    final tp = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
        maxLines: maxLines);
    tp.layout(maxWidth: maxWidth);
    return tp.computeLineMetrics().length;
  }
}
