import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
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
    final editIsbnKey = GlobalObjectKey<_CustomTextFieldState>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Share Books"),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
            child: SingleChildScrollView(
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
                                  _CustomTextField(
                                    key: editIsbnKey,
                                    onChanged: (text) {
                                      setState(() {
                                        editIsbn = text;
                                      });
                                    },
                                    hintText: "9784798056920",
                                    keyboardType: TextInputType.number,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: OutlinedButton.icon(
                                            onPressed: () async {
                                              final barcode =
                                                  await FlutterBarcodeScanner
                                                      .scanBarcode(
                                                          "ff6666",
                                                          "Cancel",
                                                          false,
                                                          ScanMode.BARCODE);
                                              if (barcode.startsWith("978")) {
                                                editIsbnKey.currentState!
                                                    .changeText(barcode);
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        title: const Text(""),
                                                        content: const Text(
                                                            "978から始まるバーコードのみ対応しています。"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "OK"))
                                                        ],
                                                      );
                                                    });
                                              }
                                            },
                                            icon: const FaIcon(
                                                FontAwesomeIcons.barcode),
                                            label: const Text("を読み取る"),
                                          )),
                                      (() {
                                        if (editIsbn != "") {
                                          return ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SharePage(
                                                      query:
                                                          ShareBooksShareQuery(
                                                              isbn: editIsbn),
                                                    ),
                                                  ));
                                            },
                                            child: const Text("共有"),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      })()
                                    ],
                                  ),
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
                                  _CustomTextField(
                                    onChanged: (text) => {
                                      setState(() {
                                        editTitle = text;
                                      })
                                    },
                                    hintText: 'この素晴らしい...',
                                    keyboardType: TextInputType.text,
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
                                            child: const Text("調べる"),
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
                                  _CustomTextField(
                                      onChanged: (value) {
                                        setState(() {
                                          editAmazonUrl = value;
                                        });
                                      },
                                      hintText:
                                          "https://www.amazon.co.jp/dp/4088831209/...",
                                      keyboardType: TextInputType.url),
                                  (() {
                                    if (editAmazonUrl != "") {
                                      return Align(
                                          alignment: Alignment.topRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final res = convertUrl2Isbn13(
                                                  editAmazonUrl);
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
                                                    builder: (context) =>
                                                        SharePage(
                                                      query:
                                                          ShareBooksShareQuery(
                                                              isbn: res.isbn),
                                                    ),
                                                  ));
                                            },
                                            child: const Text("共有"),
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
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        Image.network(
                                            'https://i.gyazo.com/c13353fcbacce087b7dd3a42985d19c0.png')
                                      ]);
                                    } else if (isOtherError) {
                                      return const Text("無効なURLです。",
                                          style: TextStyle(
                                              color: Colors.redAccent));
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
                                builder: ((context, followLink) =>
                                    GestureDetector(
                                        onTap: followLink,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Icon(
                                                Icons.help_outline,
                                                color: Colors.black45,
                                              ),
                                              Text("書籍が見つからない場合...",
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ))
                                            ])))))
                      ],
                    )))));
  }
}

class _CustomTextField extends StatefulWidget {
  const _CustomTextField(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      required this.keyboardType})
      : super(key: key);
  final void Function(String) onChanged;
  final String hintText;
  final TextInputType keyboardType;
  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          //width: double.infinity,
          child: TextField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
        ),
        onChanged: (_) {
          widget.onChanged(_controller.text);
        },
      )),
      (() {
        if (_controller.text != "") {
          return GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged(_controller.text);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black45,
              ));
        }
        return const SizedBox();
      })(),
    ]);
  }

  void changeText(String newText) {
    _controller.text = newText;
    widget.onChanged(newText);
  }
}
