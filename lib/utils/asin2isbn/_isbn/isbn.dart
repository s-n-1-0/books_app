class IsbnAndCheckdigit {
  String isbn;
  int checkdigit;
  IsbnAndCheckdigit(this.isbn, this.checkdigit);
}

IsbnAndCheckdigit? getIsbn13Checkdigit(String isbn) {
  if (isbn.length < 12 || isbn.length > 13) return null;
  var isbn12 = isbn;
  if (isbn12.length == 13) {
    isbn12 = isbn12.substring(0, isbn.length - 1);
  }
  var p1 = 0;
  var p2 = 0;
  for (var i = 0; i < isbn12.length; i += 2) {
    p1 += int.parse(isbn12[i]);
  }
  for (var i = 1; i < isbn12.length; i += 2) {
    p2 += int.parse(isbn12[i]);
  }

  var d = (p1 + p2 * 3) % 10;
  d = 10 - d;
  if (d == 10) d = 0;

  return IsbnAndCheckdigit(isbn12 + d.toString(), d);
}

/// ISBN13→ISBN10 or ISBN10→ISBN13
String? convertIsbn(String isbn) {
  if (isbn.length == 13) {
    final sum =
        isbn.split("").sublist(3, 12).asMap().entries.fold<int>(0, (prev, el) {
      var n = int.parse(el.value);
      return prev + n * (10 - el.key);
    });
    final checkDigit = 11 - (sum % 11);
    final isbn10 = isbn.substring(3, 12) + checkDigit.toString();
    return isbn10;
  } else if (isbn.length == 10) {
    var q = "978$isbn";
    var isbn13 = getIsbn13Checkdigit(q)?.isbn;
    return isbn13;
  }
  return null;
}
