import 'dart:ui';

import 'package:flutter/material.dart';

//高斯模糊组件封装
class BlurWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double sigma;

  const BlurWidget({Key? key, this.sigma = 10, this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: Container(
        color: color,
        child: child,
      ),
    );
  }
}
