import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/review_request.dart';

void shareCount() async {
  const saveKey = "shareCount";
  SharedPreferences pref = await SharedPreferences.getInstance();
  int count = pref.getInt(saveKey) ?? 0;
  count++;
  pref.setInt(saveKey, count);

  switch (count) {
    case 2:
    case 7:
    case 15:
      requestReview();
      break;
  }
}

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
                    shareCount();
                  }
                  break;
                case "default":
                  shareCount();
                  break;
              }
            }
          },
        );
        controller.addJavaScriptHandler(
            handlerName: "readClipboardText",
            callback: (args) async {
              return (await Clipboard.getData(Clipboard.kTextPlain))?.text ??
                  "";
            });
        controller.addJavaScriptHandler(
            handlerName: "writeClipboardText",
            callback: (args) async {
              final res = args.firstOrNull;
              if (res != null && res["text"] != null) {
                await Clipboard.setData(
                    ClipboardData(text: res["text"] as String));
              }
            });
      },
    );
  }
}
