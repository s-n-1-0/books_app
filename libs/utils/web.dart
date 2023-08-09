const webOrigin = "https://books.sn-10.net";

//共有に必要な最低限のBookData
class BaseBookData {
  BaseBookData({required this.isbn, this.from = "", this.comment = ""});
  String isbn;

  /// 空文字の場合は未指定(=openbd) "openbd" | googlebooks
  String from;

  /// 空文字の場合は未指定
  String comment;

  final String _sharePageUrl = "$webOrigin/ja/share";
  String getBookDataUrl() {
    var url = "$_sharePageUrl?isbn=${Uri.encodeFull(isbn)}";
    if (from != "") url += "&from=${Uri.encodeFull(from)}";
    if (comment != "") url += "&comment=${Uri.encodeComponent(comment)}";
    return url;
  }
}
