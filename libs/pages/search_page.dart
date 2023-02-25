import 'package:flutter/material.dart';
import '../components/common_webview.dart';
import '../utils/web.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const CommonWebView("$webOrigin/ja/share");
  }
}
