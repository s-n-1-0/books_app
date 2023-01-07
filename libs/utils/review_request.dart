import 'dart:io';
import 'package:app_review/app_review.dart';

void requestReview() async {
  if (Platform.isIOS) {
    AppReview.requestReview.then((onValue) {});
  }
}
