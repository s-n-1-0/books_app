import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

const googleBooksUrl = "https://www.googleapis.com/books/v1/volumes";

class GoogleBooksApiBookDataIndustryIdentifier {
  /// "ISBN_10" | "ISBN_13" | "PKEY"
  late String type;
  late String identifier;
  GoogleBooksApiBookDataIndustryIdentifier.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    identifier = json["identifier"];
  }
}

class GoogleBooksApiBookDataInfoImageLinks {
  late String smallThumbnail;
  late String thumbnail;
  GoogleBooksApiBookDataInfoImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json["smallThumbnail"];
    thumbnail = json["thumbnail"];
  }
}

class GoogleBooksApiBookDataInfo {
  late String title;
  late List<String> authors;
  late String? publisher;
  late List<GoogleBooksApiBookDataIndustryIdentifier> industryIdentifiers;
  late GoogleBooksApiBookDataInfoImageLinks? imageLinks;
  late String? description;

  GoogleBooksApiBookDataInfo.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    authors = (json["authors"] as List).map((item) => item as String).toList();
    publisher = json["publisher"];
    industryIdentifiers = (json["industryIdentifiers"] as List)
        .map((item) => GoogleBooksApiBookDataIndustryIdentifier.fromJson(item))
        .toList();
    final il = json["imageLinks"];
    imageLinks =
        il == null ? null : GoogleBooksApiBookDataInfoImageLinks.fromJson(il);
    description = json["description"];
  }
}

class GoogleBooksApiBookData {
  late String id;
  late GoogleBooksApiBookDataInfo volumeInfo;
  GoogleBooksApiBookData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    volumeInfo = GoogleBooksApiBookDataInfo.fromJson(json["volumeInfo"]);
  }
}

class GoogleBooksApiVolumesResponseData {
  late String kind;
  late int totalItems;
  late List<GoogleBooksApiBookData>? items;
  GoogleBooksApiVolumesResponseData.fromJson(Map<String, dynamic> json) {
    kind = json["kind"];
    totalItems = json["totalItems"];
    items = json["items"] == null
        ? null
        : (json["items"] as List)
            .map((item) => GoogleBooksApiBookData.fromJson(item))
            .toList();
  }
}

class GoogleBooksApiRequestQOption {
  String? intitle;
  String? isbn;
  GoogleBooksApiRequestQOption({this.intitle, this.isbn});
}

class GoogleBooksApiRequest {
  GoogleBooksApiRequestQOption q;
  int? startIndex;
  GoogleBooksApiRequest(this.q, {this.startIndex});
}

Future<GoogleBooksApiVolumesResponseData?> searchGoogleBooksApi(
    GoogleBooksApiRequest query) async {
  var url = "$googleBooksUrl?q=";
  final q = query.q;
  var isQ = false;
  if (q.intitle != null) {
    isQ = true;
    url += "intitle:${Uri.encodeFull(q.intitle!)}";
  }
  if (q.isbn != null) {
    if (isQ) url += "+";
    isQ = true;
    url += "isbn:${q.isbn!}";
  }
  final res =
      await http.get(Uri.parse("$url&startIndex=${query.startIndex ?? 0}"));
  if (res.statusCode != 200) return null;
  return GoogleBooksApiVolumesResponseData.fromJson(json.decode(res.body));
}

Future<GoogleBooksApiBookData?> searchGoogleBooksApiByIsbn(String isbn) async {
  final data = await searchGoogleBooksApi(
      GoogleBooksApiRequest(GoogleBooksApiRequestQOption(isbn: isbn)));
  final book = (data?.items ?? []).firstWhereOrNull((item) {
    final id = item.volumeInfo.industryIdentifiers
        .firstWhereOrNull((id) => id.identifier == isbn);
    return id != null;
  });
  return book;
}
