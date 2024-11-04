import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/card_generation_page.dart';
import 'book_card.dart';

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
      // NOTE: レビューライブラリが古い＆レビュー依頼できる品質ではないので、一時的にレビュー機能を停止している。
      // requestReview();
      break;
  }
}

class CommonWebView extends StatefulWidget {
  const CommonWebView(this.url, {super.key});
  final String url;
  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  InAppWebViewController? _webViewController;
  bool _isCanGoBack = false;
  bool _isCanGoForward = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                _webViewController?.loadUrl(
                    urlRequest: URLRequest(url: WebUri(widget.url)));
              },
              child: const Text("Share Books")),
          centerTitle: false,
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Visibility(
                  visible: _isCanGoBack || _isCanGoForward,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: _isCanGoBack,
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            child: ElevatedButton(
                              onPressed: () {
                                _webViewController?.goBack();
                              },
                              child: const Icon(Icons.undo),
                            )),
                        Visibility(
                            visible: _isCanGoForward,
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            child: ElevatedButton(
                              onPressed: () {
                                _webViewController?.goForward();
                              },
                              child: const Icon(Icons.redo),
                            ))
                      ]),
                ))
          ],
        ),
        body: Column(children: [
          Expanded(
              child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(supportZoom: false),
                android: AndroidInAppWebViewOptions(
                    mixedContentMode:
                        AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              controller.addJavaScriptHandler(
                handlerName: 'completedSharing',
                callback: (args) {
                  final res = args.firstOrNull;
                  if (res != null) {
                    switch (res["type"] ?? "") {
                      case "twitter":
                        final String twitterUrl = res["url"] ?? "";
                        if (twitterUrl != "" &&
                            twitterUrl
                                .startsWith("https://twitter.com/share")) {
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
                  handlerName: "requestBarcodeReader",
                  callback: (args) async {
                    final barcode = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666", "Cancel", false, ScanMode.BARCODE);
                    if (barcode.startsWith("978")) {
                      return barcode;
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text(""),
                              content: const Text("978から始まるバーコードのみ対応しています。"),
                              actions: [
                                Builder(builder: (context) {
                                  return TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"));
                                })
                              ],
                            );
                          });
                      return "";
                    }
                  });
              controller.addJavaScriptHandler(
                  handlerName: "requestCardGeneration",
                  callback: (args) {
                    final bookData = args.firstOrNull;
                    if (bookData != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardGenerationPage(
                                  bookData: BookCardData(
                                      title: bookData["title"] ?? "",
                                      author: bookData["author"] ?? "",
                                      coverUrl: bookData["thumbnail"] ?? "",
                                      isbn: bookData["isbn"] ?? "",
                                      from: bookData["from"] ?? "",
                                      comment: bookData["comment"] ?? ""),
                                )),
                      );
                    }
                  });
              controller.addJavaScriptHandler(
                  handlerName: "getAppBuildNumber",
                  callback: (args) async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    final buildStr = packageInfo.buildNumber;
                    return int.parse(buildStr);
                  });
              controller.addJavaScriptHandler(
                  handlerName: "readClipboardText",
                  callback: (args) async {
                    return (await Clipboard.getData(Clipboard.kTextPlain))
                            ?.text ??
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
            onLoadStop: (controller, url) async {
              final isCanGoBack = await controller.canGoBack();
              final isCanGoForward = await controller.canGoForward();
              setState(() {
                _isCanGoBack = isCanGoBack;
                _isCanGoForward = isCanGoForward;
              });
            },
          ))
        ]));
  }
}
