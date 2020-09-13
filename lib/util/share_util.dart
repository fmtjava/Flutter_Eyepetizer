

import 'package:share/share.dart';

class ShareUtil{

  ShareUtil._();

  static void share(String title,String content){
    Share.share('$title\n$content');
  }

}