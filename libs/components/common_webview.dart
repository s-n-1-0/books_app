import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)),
      onWebViewCreated: (controller) {
        controller.addJavaScriptHandler(
          handlerName: 'completedSharing',
          callback: (args) {
            final res = args.firstOrNull;
            if (res != null) {
              switch (res["type"] ?? "") {
                case "twitter":
                  final String twitterUrl = res["url"] ?? "";
                  if (twitterUrl != "" &&
                      twitterUrl.startsWith("https://twitter.com/share")) {
                    launchUrl(Uri.parse(twitterUrl));
                  }
                  break;
                case "default":
                  break;
              }
            }
          },
        );
      },
    );
  }
}
