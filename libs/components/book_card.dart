import 'dart:ffi';

import 'package:flutter/material.dart';

class BookCardData {
  BookCardData(this.title, this.isbn, this.auther, this.coverURL);
  final String title, isbn, auther, coverURL;
}

final sampleBookCardData = BookCardData(
    "Docker&仮想サーバー完全入門　Webクリエイター＆エンジニアの作業がはかどる開発環境構築ガイド",
    "9780123456789",
    "オーキド",
    "https://cover.openbd.jp/9784295015314.jpg");

class BookCard extends StatelessWidget {
  const BookCard(this.data, {super.key});
  final BookCardData data;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage("assets/mid_card_bg.png"),
              fit: BoxFit.fill,
            )),
        child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black, fontSize: 40),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(75, 65, 100, 75),
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
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 25, 0),
                            child: Image.network(
                              data.coverURL,
                              fit: BoxFit.contain,
                              height: 300,
                            )),
                        Flexible(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.title,
                                      style: const TextStyle(fontSize: 50),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(data.auther),
                                            Text(data.isbn)
                                          ],
                                        ))
                                  ],
                                )))
                      ],
                    )))));
  }
}
