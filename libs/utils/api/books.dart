import 'package:collection/collection.dart';
import 'googlebooks.dart';
import 'openbd.dart';

/// 書籍データ共通クラス
class ShareBookBaseData {
  String title = "",
      isbn13 = "",
      isbn10 = "",
      description = "",
      author = "",
      publisher = "",
      coverUrl = "";
  ShareBookBaseData();
  ShareBookBaseData.fromGoogleBooks(GoogleBooksApiBookDataInfo info) {
    title = info.title;
    isbn13 = info.isbn13 ?? "";
    isbn10 = info.isbn10 ?? "";
    description = info.description ?? "";
    author = info.authors.firstOrNull ?? "";
    publisher = info.publisher ?? "";
    coverUrl = info.imageLinks?.smallThumbnail ?? "";
  }
  ShareBookBaseData.fromOpenbd(OpenBdGetResponseBookData data) {
    title = data.summary.title;
    isbn13 = data.summary.isbn13 ?? "";
    isbn10 = data.summary.isbn10 ?? "";
    description =
        data.onix.CollateralDetail.TextContent.firstOrNull?.Text ?? "";
    author = data.summary.author;
    publisher = data.summary.publisher;
    coverUrl = data.summary.cover;
  }

  /// ISBNを取得します(優先13桁)
  String get isbn => isbn13 != "" ? isbn13 : isbn10;
}
