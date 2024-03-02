import 'package:flutter/material.dart';
import 'package:lib_ui/config/string.dart';
import 'package:readmore/readmore.dart';

enum TrimTypeMode {
  Length,
  Line,
}

class ReadMoreTextWidget extends StatelessWidget {
  final String text;
  final String trimCollapsedText;
  final String trimExpandedText;
  final TextStyle? style;
  final TextStyle? moreStyle;
  final TextStyle? lessStyle;
  final int trimLines;
  final TrimTypeMode trimMode;

  const ReadMoreTextWidget(this.text,
      {Key? key,
      this.trimCollapsedText = more_text,
      this.trimExpandedText = less_text,
      this.style,
      this.moreStyle,
      this.lessStyle,
      this.trimLines = 2,
      this.trimMode = TrimTypeMode.Line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      trimMode: trimMode == TrimTypeMode.Line ? TrimMode.Line : TrimMode.Length,
      trimCollapsedText: trimCollapsedText,
      trimExpandedText: trimExpandedText,
      style: style,
      moreStyle: moreStyle,
      lessStyle: lessStyle,
    );
  }
}
