import 'asin2isbn.dart';

String convertUrl2Asin(String url) {
  try {
    final names = Uri.parse(url).path.split("/");
    final q = names.indexOf("dp");
    if (q == -1) return "";
    return names[q + 1];
  } catch (e) {
    return "";
  }
}

ConvertIsbnResponse convertUrl2Isbn13(String url) {
  final asin = convertUrl2Asin(url);
  if (asin == "") return ConvertIsbnResponse.set("", "FORMAT");
  return convertAsin2Isbn13(asin);
}
