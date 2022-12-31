import 'package:app/utils/asin2isbn/asin2isbn.dart';
import 'package:app/utils/asin2isbn/isbn.dart';
import 'package:app/utils/asin2isbn/url2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('asinisbn dart test', () {
    //asin -> isbn test
    var res = convertAsin2Isbn13("4596708460");
    expect(res, ConvertIsbnResponse.set("9784596708465", ""));

    res = convertAsin2Isbn13("4799215663");
    expect(res, ConvertIsbnResponse.set("9784799215661", ""));

    res = convertAsin2Isbn13("B09MYHB3X3");
    expect(res, ConvertIsbnResponse.set("", "KINDLE"));

    //url→asin
    final asin = convertUrl2Asin(
        "https://www.amazon.co.jp/dp/4799215663/ref=cm_sw_r_tw_dp_5XW9TEXBPTC54CE90CE9");
    expect(asin, "4799215663");
    // url→isbn13
    expect(
        convertUrl2Isbn13(
            "https://www.amazon.co.jp/dp/4799215663/ref=cm_sw_r_tw_dp_5XW9TEXBPTC54CE90CE9"),
        ConvertIsbnResponse.set("9784799215661", ""));

    //URL Error Case
    expect(
        convertUrl2Isbn13("urlerror"), ConvertIsbnResponse.set("", "FORMAT"));

    //ISBN13 -> ISBN10
    expect(convertIsbn("9784799215661"), "4799215663");
    debugPrint("9784799215661 => ${convertIsbn("9784799215661")}");
    //ISBN13 -> URL
    expect(convertIsbn2Url("9784799215661"),
        "https://www.amazon.co.jp/dp/4799215663");
    debugPrint("9784799215661 => ${convertIsbn2Url("9784799215661")}");
  });
}
