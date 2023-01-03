import 'package:flutter_test/flutter_test.dart';
import '../../libs/utils/api/googlebooks.dart' as googlebooks;

void main() {
  test('googlebooks api test', () async {
    /// isbn search
    /// https://www.googleapis.com/books/v1/volumes?q=isbn:9784799215661
    final res =
        (await googlebooks.searchGoogleBooksApiByIsbn("9784799215661"))!;
    expect(res.id, "00KjzgEACAAJ");
    final info = res.volumeInfo;
    expect(info.title, "根津さんの恩返し 1");
    expect(info.authors[0], "ハマサキ");
    expect(info.publisher, null);
    expect(info.isbn10, "4799215663");
    expect(info.isbn13, "9784799215661");
    expect(info.imageLinks, null);
    expect(info.description, "【コミュ障OL×お助けネズミ】による1人と1匹のコミュ障克服を目指す日常コメディ!");
    //実行のみテスト
    await googlebooks.searchGoogleBooksApi(googlebooks.GoogleBooksApiRequest(
        googlebooks.GoogleBooksApiRequestQOption(intitle: "辛い")));
  });
}
