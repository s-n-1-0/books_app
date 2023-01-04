import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CommonWebView extends StatelessWidget {
  const CommonWebView(this.url, {super.key});
  final String url;
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
                mixedContentMode:
                    AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)));
  }
}
