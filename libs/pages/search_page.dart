import 'package:flutter/material.dart';

import 'share_page.dart';
import 'title_search_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String editIsbn = "";
  String editTitle = "";
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
                          TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "9784798056920",
                                isDense: true,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  editIsbn = text;
                                });
                              }),
                          (() {
                            if (editIsbn != "") {
                              return Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SharePage(
                                              query: ShareBooksShareQuery(
                                                  isbn: editIsbn),
                                            ),
                                          ));
                                    },
                                    child: const Text("検索"),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          })(),
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
                          TextField(
                            decoration: const InputDecoration(
                              hintText: "この素晴らしい...",
                              isDense: true,
                            ),
                            onChanged: (text) => {
                              setState(() {
                                editTitle = text;
                              })
                            },
                          ),
                          Text("タイトル検索で書籍が見つからない場合はISBN検索をお試しください。",
                              style: textTheme.caption),
                          (() {
                            if (editTitle != "") {
                              return Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchResultsPage(
                                                      query:
                                                          ShareBooksSearchQuery(
                                                              title:
                                                                  editTitle))));
                                    },
                                    child: const Text("検索"),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          })()
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
