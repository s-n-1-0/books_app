import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/link.dart';
import '../utils/color.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});
  @override
  State<StatefulWidget> createState() => _InfoPageState();
}

class _InfoPageState extends State<StatefulWidget> {
  var appVersion = "";
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        appVersion = info.version;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Books"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.phone_iphone,
              color: CustomColors.app,
            ),
            title: const Text("Appバージョン"),
            trailing: Text(appVersion),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(children: [
                Text(
                  "要望や不具合報告はこちらへ",
                  style: textTheme.caption,
                ),
                Link(
                    uri: Uri.parse('https://forms.gle/UnceoUa8S38SU6Zq9'),
                    target: LinkTarget.blank,
                    builder: (context, followLink) => ElevatedButton(
                        onPressed: followLink, child: const Text("要望・バグ報告")))
              ]))
        ],
      ),
    );
  }
}
