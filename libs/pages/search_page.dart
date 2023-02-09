import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../components/search_blocks.dart';
import '../utils/web.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
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
                        const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: SearchIsbnBlock()),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: SearchTitleBlock()),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: SearchUrlBlock()),
                        const Divider(
                          height: 30,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Link(
                                uri: Uri.parse('$webOrigin/ja/help/find'),
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
