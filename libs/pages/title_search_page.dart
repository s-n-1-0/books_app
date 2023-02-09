import 'package:flutter/material.dart';
import '../components/common_webview.dart';
import '../utils/web.dart';

class ShareBooksSearchQuery {
  String title;
  ShareBooksSearchQuery({required this.title});

  final String _sharePageUrl = "$webOrigin/app/search";
  String getBookDataUrl() {
    var url = "$_sharePageUrl?";
    url += "title=${Uri.encodeComponent(title)}}";
    return url;
  }
}

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key, required this.query});
  final ShareBooksSearchQuery query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CommonWebView(query.getBookDataUrl()),
    );
  }
}
