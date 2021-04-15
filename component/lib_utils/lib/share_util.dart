import 'package:share/share.dart';

void share(String title, String content) {
  Share.share('$title\n$content');
}
