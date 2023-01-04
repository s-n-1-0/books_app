import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShareBooksShareQuery {
  String isbn;

  /// 空文字の場合は未指定(=openbd) "openbd" | googlebooks
  String from;

  /// 空文字の場合は未指定
  String comment;

  ShareBooksShareQuery({required this.isbn, this.from = "", this.comment = ""});

  final String _sharePageUrl = "https://books.sn-10.net/ja/share";
  String getBookDataUrl() {
    var url = "$_sharePageUrl?";
    url += "isbn=${Uri.encodeFull(isbn)}";
    if (from != "") url += "&from=${Uri.encodeFull(from)}";
    if (comment != "") url += "&comment=${Uri.encodeComponent(comment)}";
    return url;
  }
}

class SharePage extends StatelessWidget {
  const SharePage({super.key, required this.query});
  final ShareBooksShareQuery query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: query.getBookDataUrl(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
