

import 'package:share/share.dart';

class ShareUtil{

  static void share(String title,String content){
    Share.share('$title\n$content');
  }

}