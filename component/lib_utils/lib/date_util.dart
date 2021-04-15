import 'package:flustars/flustars.dart';

String formatDateMsByMS(int milliseconds) {
  return DateUtil.formatDateMs(milliseconds, format: 'mm:ss');
}

String formatDateMsByYMD(int milliseconds) {
  return DateUtil.formatDateMs(milliseconds, format: 'yyyy/MM/dd');
}

String formatDateMsByYMDHM(int milliseconds) {
  return DateUtil.formatDateMs(milliseconds, format: 'yyyy/MM/dd HH:mm');
}
