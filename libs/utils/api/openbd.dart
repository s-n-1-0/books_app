// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://api.OpenBd.jp/v1';

class OpenBdBookDataOnixCollateralDetailTextContent {
  late String Text;
  OpenBdBookDataOnixCollateralDetailTextContent.fromJson(
      Map<String, dynamic> json) {
    Text = json["Text"];
  }
}

class OpenBdBookDataOnixCollateralDetail {
  late List<OpenBdBookDataOnixCollateralDetailTextContent> TextContent;
  OpenBdBookDataOnixCollateralDetail.fromJson(Map<String, dynamic> json) {
    TextContent = (json["TextContent"] as List)
        .map<OpenBdBookDataOnixCollateralDetailTextContent>(
            (el) => OpenBdBookDataOnixCollateralDetailTextContent.fromJson(el))
        .toList();
  }
}

class OpenBdBookDataOnix {
  late OpenBdBookDataOnixCollateralDetail CollateralDetail;
  OpenBdBookDataOnix.fromJson(Map<String, dynamic> json) {
    CollateralDetail =
        OpenBdBookDataOnixCollateralDetail.fromJson(json["CollateralDetail"]);
  }
}

class OpenBdBookDataSummary {
  late String isbn, title, publisher, volume, series, author, pubdate, cover;
  OpenBdBookDataSummary.fromJson(Map<String, dynamic> json) {
    isbn = json["isbn"];
    title = json["title"];
    publisher = json["publisher"];
    volume = json["volume"];
    series = json["series"];
    author = json["author"];
    pubdate = json["pubdate"];
    cover = json["cover"];
  }
}

class OpenBdGetResponseBookData {
  late OpenBdBookDataSummary summary;
  late OpenBdBookDataOnix onix;

  OpenBdGetResponseBookData.fromJson(Map<String, dynamic> json) {
    summary = OpenBdBookDataSummary.fromJson(json["summary"]);
    onix = OpenBdBookDataOnix.fromJson(json["onix"]);
  }
}

Future<List<OpenBdGetResponseBookData>?> get(
    {String isbns = "", List<String> isbnsList = const []}) async {
  if (isbnsList.isNotEmpty) {
    isbns += (isbns == "") ? isbnsList.join(',') : ",${isbnsList.join(',')}";
  }
  final res = await http.get(Uri.parse("$url/get?isbn=$isbns"));
  if (res.statusCode != 200) return null;
  return (json.decode(res.body) as List)
      .map((el) => OpenBdGetResponseBookData.fromJson(el))
      .toList();
}
