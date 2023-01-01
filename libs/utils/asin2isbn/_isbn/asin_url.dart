import 'isbn.dart';

/// ISBN10-> ASIN or ISBN13->ASIN
String? convertIsbn2Asin(String isbn) {
  if (isbn.length == 10) return isbn; //ISBN10 == ASIN
  if (isbn.length == 13) return convertIsbn(isbn);
  return null;
}

/// ISBN10 -> Amazon URL or ISBN13 -> AmazonURL
String? convertIsbn2Url(String isbn) {
  final asin = convertIsbn2Asin(isbn);
  if (asin == null) return null;
  return "https://www.amazon.co.jp/dp/${Uri.encodeFull(asin)}";
}
