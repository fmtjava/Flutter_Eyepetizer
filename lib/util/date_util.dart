import 'package:flustars/flustars.dart';

class DateUtils {
  DateUtils._();

  static String formatDateMsByMS(int milliseconds) {
    return DateUtil.formatDateMs(milliseconds, format: 'mm:ss');
  }

  static String formatDateMsByYMD(int milliseconds) {
    return DateUtil.formatDateMs(milliseconds, format: 'yyyy/MM/dd');
  }

  static String formatDateMsByYMDHM(int milliseconds) {
    return DateUtil.formatDateMs(milliseconds, format: 'yyyy/MM/dd HH:mm');
  }
}
