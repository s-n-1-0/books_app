import 'package:flutter/material.dart';

import '../components/common_webview.dart';
import '../utils/web.dart';

class ShareBooksShareQuery {
  String isbn;

  /// 空文字の場合は未指定(=openbd) "openbd" | googlebooks
  String from;

  /// 空文字の場合は未指定
  String comment;

  ShareBooksShareQuery({required this.isbn, this.from = "", this.comment = ""});

  final String _sharePageUrl = "$webOrigin/ja/share";
  String getBookDataUrl() {
    var url = "$_sharePageUrl?isbn=${Uri.encodeFull(isbn)}";
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
        appBar: AppBar(), body: CommonWebView(query.getBookDataUrl()));
  }
}
