import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../pages/share_page.dart';
import '../custom_text_field.dart';

class SearchIsbnBlock extends StatefulWidget {
  const SearchIsbnBlock({super.key});

  @override
  State<SearchIsbnBlock> createState() => _SearchIsbnBlockState();
}

class _SearchIsbnBlockState extends State<SearchIsbnBlock> {
  String editIsbn = "";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final editIsbnKey = GlobalObjectKey<CustomTextFieldState>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "ISBNで共有",
        style: textTheme.subtitle1,
      ),
      CustomTextField(
        key: editIsbnKey,
        onChanged: (text) {
          setState(() {
            editIsbn = text;
          });
        },
        hintText: "9784798056920",
        keyboardType: TextInputType.number,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: OutlinedButton.icon(
                onPressed: () async {
                  final barcode = await FlutterBarcodeScanner.scanBarcode(
                      "ff6666", "Cancel", false, ScanMode.BARCODE);
                  if (barcode.startsWith("978")) {
                    editIsbnKey.currentState!.changeText(barcode);
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text(""),
                            content: const Text("978から始まるバーコードのみ対応しています。"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          );
                        });
                  }
                },
                icon: const FaIcon(FontAwesomeIcons.barcode),
                label: const Text("を読み取る"),
              )),
          (() {
            if (editIsbn != "") {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SharePage(
                          query: ShareBooksShareQuery(isbn: editIsbn),
                        ),
                      ));
                },
                child: const Text("共有"),
              );
            } else {
              return const SizedBox();
            }
          })()
        ],
      ),
    ]);
  }
}
