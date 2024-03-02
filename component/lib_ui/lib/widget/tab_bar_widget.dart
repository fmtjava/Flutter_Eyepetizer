import 'package:flutter/material.dart';
import 'package:lib_ui/config/color.dart';

//通用的TabBar封装
class TabBarWidget extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color indicatorColor;
  final double fontSize;
  final TabBarIndicatorSize indicatorSize;
  final ValueChanged<int>? onTap;

  const TabBarWidget(
      {Key? key,
      required this.tabs,
      this.tabController,
      this.labelColor = Colors.black,
      this.unselectedLabelColor = hitTextColor,
      this.indicatorColor = Colors.black,
      this.fontSize = 14,
      this.indicatorSize = TabBarIndicatorSize.label,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabController,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        unselectedLabelStyle: TextStyle(fontSize: fontSize),
        indicatorColor: indicatorColor,
        indicatorSize: indicatorSize,
        tabs: tabs,
        onTap: (index) => onTap?.call(index));
  }
}
