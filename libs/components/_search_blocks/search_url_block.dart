import 'package:flutter/material.dart';

import '../../pages/share_page.dart';
import '../../utils/asin2isbn/url2.dart';
import '../custom_text_field.dart';

class SearchUrlBlock extends StatefulWidget {
  const SearchUrlBlock({super.key});
  @override
  State<SearchUrlBlock> createState() => _SearchUrlBlockState();
}

class _SearchUrlBlockState extends State<SearchUrlBlock> {
  String editAmazonUrl = "";
  bool isKindleError = false;
  bool isOtherError = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Amazon URLで共有",
        style: textTheme.subtitle1,
      ),
      Text("商品ページのURLを貼り付けてください。", style: textTheme.caption),
      CustomTextField(
          onChanged: (value) {
            setState(() {
              editAmazonUrl = value;
            });
          },
          hintText: "https://www.amazon.co.jp/dp/4088831209/...",
          keyboardType: TextInputType.url),
      (() {
        if (editAmazonUrl != "") {
          return Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  final res = convertUrl2Isbn13(editAmazonUrl);
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
                          query: ShareBooksShareQuery(isbn: res.isbn),
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
              style: TextStyle(color: Colors.redAccent),
            ),
            Image.network(
                'https://i.gyazo.com/c13353fcbacce087b7dd3a42985d19c0.png')
          ]);
        } else if (isOtherError) {
          return const Text("無効なURLです。",
              style: TextStyle(color: Colors.redAccent));
        }
        return const SizedBox();
      })()
    ]);
  }
}
