import 'package:flutter/material.dart';

import '../components/common_webview.dart';
import '../utils/web.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key, required this.query});
  final BaseBookData query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: CommonWebView(query.getBookDataUrl()));
  }
}
