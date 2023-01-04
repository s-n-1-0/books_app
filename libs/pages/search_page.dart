import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
        child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "以下の方法で書籍を共有することができます。",
                              style: textTheme.headline6,
                            )
                          ],
                        ))),
                Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ISBNで共有",
                            style: textTheme.subtitle1,
                          ),
                          const TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "9784798056920",
                                isDense: true,
                              ))
                        ])),
                Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "タイトルで調べる",
                            style: textTheme.subtitle1,
                          ),
                          const TextField(
                              decoration: InputDecoration(
                            hintText: "この素晴らしい...",
                            isDense: true,
                          )),
                          Text("タイトル検索で書籍が見つからない場合はISBN検索をお試しください。",
                              style: textTheme.caption)
                        ])),
                Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amazon URLで共有",
                            style: textTheme.subtitle1,
                          ),
                          Text("商品ページのURLを貼り付けてください。",
                              style: textTheme.caption),
                          const TextField(
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                hintText:
                                    "https://www.amazon.co.jp/dp/4088831209/...",
                                isDense: true,
                              )),
                        ])),
                const Divider(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "書籍が見つからない場合...",
                            style: TextStyle(color: Colors.black45),
                          )
                        ]))
              ],
            )));
  }
}
