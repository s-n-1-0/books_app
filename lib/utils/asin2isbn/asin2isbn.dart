import 'dart:ui';

import 'isbn.dart';

class ConvertIsbnResponse {
  /// "FORMAT" | "KINDLE" | ""
  String error = "";
  String isbn = "";
  ConvertIsbnResponse();
  ConvertIsbnResponse.set(this.isbn, this.error);

  @override
  bool operator ==(other) =>
      other is ConvertIsbnResponse &&
      other.isbn == isbn &&
      other.error == error;

  @override
  int get hashCode => Object.hash(isbn, error);
}

ConvertIsbnResponse convertAsin2Isbn13(String asin) {
  var res = ConvertIsbnResponse();
  if (asin[0] == "B") {
    res.error = "KINDLE";
    return res;
  }
  if (asin.length != 10) {
    res.error = "FORMAT";
    return res;
  }
  String? isbn = convertIsbn(asin);
  res.isbn = isbn ?? "";
  res.error = isbn == null ? "FORMAT" : "";
  return res;
}
