import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

//封装带缓存的Image
Widget cacheImage(String url,
    {double width,
      double height,
      fit: BoxFit.cover,
      BorderRadius borderRadius,
      BoxShape shape = BoxShape.rectangle,
      bool clearMemoryCacheWhenDispose = false}) {
  return ExtendedImage.network(
    url,
    shape: shape,
    height: height,
    width: width,
    fit: fit,
    borderRadius: borderRadius,
    clearMemoryCacheWhenDispose:
    clearMemoryCacheWhenDispose, //图片从 tree 中移除，清掉内存缓存，以减少内存压力
  );
}

ImageProvider cachedNetworkImageProvider(String url) {
  return ExtendedNetworkImageProvider(url);
}

//底部线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}
