import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/asin2isbn/url2.dart';
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
  String editAmazonUrl = "";
  bool isKindleError = false;
  bool isOtherError = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Share Books"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 20),
                        child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  const WidgetSpan(
                                      child: Icon(
                                    Icons.ios_share,
                                  )),
                                  TextSpan(
                                    text: "以下の方法で書籍を共有することができます。",
                                    style: textTheme.headline6,
                                  )
                                ]))
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
                                                          query: ShareBooksSearchQuery(
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
                              TextField(
                                keyboardType: TextInputType.url,
                                decoration: const InputDecoration(
                                  hintText:
                                      "https://www.amazon.co.jp/dp/4088831209/...",
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    editAmazonUrl = value;
                                  });
                                },
                              ),
                              (() {
                                if (editAmazonUrl != "") {
                                  return Align(
                                      alignment: Alignment.topRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final res =
                                              convertUrl2Isbn13(editAmazonUrl);
                                          if (res.error != "") {
                                            setState(() {
                                              if (res.error == "KINDLE") {
                                                isKindleError = true;
                                              } else {
                                                isOtherError = true;
                                              }
                                            });
                                            return;
                                          }
                                          setState(() {
                                            isKindleError = false;
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SharePage(
                                                  query: ShareBooksShareQuery(
                                                      isbn: res.isbn),
                                                ),
                                              ));
                                        },
                                        child: const Text("検索"),
                                      ));
                                } else {
                                  return const SizedBox();
                                }
                              })(),
                              (() {
                                if (isKindleError) {
                                  return Column(children: [
                                    const Text(
                                      "Kindle(電子書籍)のURLは現在非対応です。Amazonの商品ページで紙の書籍を選択してください。",
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    Image.network(
                                        'https://i.gyazo.com/c13353fcbacce087b7dd3a42985d19c0.png')
                                  ]);
                                } else if (isOtherError) {
                                  return const Text("無効なURLです。",
                                      style:
                                          TextStyle(color: Colors.redAccent));
                                }
                                return const SizedBox();
                              })()
                            ])),
                    const Divider(
                      height: 30,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Link(
                            uri: Uri.parse(
                                'https://books.sn-10.net/ja/help/find'),
                            target: LinkTarget.blank,
                            builder: ((context, followLink) => GestureDetector(
                                onTap: followLink,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(
                                        Icons.help_outline,
                                        color: Colors.black45,
                                      ),
                                      Text("書籍が見つからない場合...",
                                          style: TextStyle(
                                            color: Colors.black45,
                                            decoration:
                                                TextDecoration.underline,
                                          ))
                                    ])))))
                  ],
                ))));
  }
}
