import 'package:flutter/material.dart';

import '../../pages/title_search_page.dart';
import '../custom_text_field.dart';

class SearchTitleBlock extends StatefulWidget {
  const SearchTitleBlock({super.key});
  @override
  State<SearchTitleBlock> createState() => _SearchTitleBlockState();
}

class _SearchTitleBlockState extends State<SearchTitleBlock> {
  String editTitle = "";
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "タイトルで調べる",
        style: textTheme.subtitle1,
      ),
      CustomTextField(
        onChanged: (text) => {
          setState(() {
            editTitle = text;
          })
        },
        hintText: 'この素晴らしい...',
        keyboardType: TextInputType.text,
      ),
      Text("タイトル検索で書籍が見つからない場合はISBN検索をお試しください。", style: textTheme.caption),
      (() {
        if (editTitle != "") {
          return Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResultsPage(
                              query: ShareBooksSearchQuery(title: editTitle))));
                },
                child: const Text("調べる"),
              ));
        } else {
          return const SizedBox();
        }
      })()
    ]);
  }
}
