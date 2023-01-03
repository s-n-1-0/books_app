import 'package:flutter_test/flutter_test.dart';
import '../../libs/utils/api/openbd.dart' as openbd;

void main() {
  test('openbd api test', () async {
    final res = await openbd.get(isbns: "9784799215661");
    final bookData = res!.first;

    //onix-CollateralDetail-TextContent[0]
    final onix = bookData.onix;
    expect(onix.CollateralDetail.TextContent[0].Text,
        "【コミュ障ＯＬ×お助けネズミ】による１人と１匹のコミュ障克服を目指す日常コメディ！");

    //summary
    final summary = bookData.summary;
    expect(summary.isbn13, "9784799215661");
    expect(summary.title, "根津さんの恩返し　１");
    expect(summary.volume, "");
    expect(summary.series, "");
    expect(summary.publisher, "キルタイムコミュニケーション");
    expect(summary.pubdate, "20211115");
    expect(summary.cover, "");
    expect(summary.author, "ハマサキ／著");
  });
}
