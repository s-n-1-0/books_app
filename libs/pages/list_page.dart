import 'package:flutter/material.dart';
import '../components/common_webview.dart';
import '../utils/web.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const CommonWebView("$webOrigin/ja/share/list");
  }
}
