import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:lib_utils/date_util.dart';
import 'package:module_common/model/common_item_model.dart';

class SpecialHorizontalWidgetItem extends StatelessWidget {
  final Item? item;
  final isLast;

  const SpecialHorizontalWidgetItem({Key? key, this.isLast, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 10, right: isLast ? 15 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => toNamed("/detail", item?.data),
            child: Hero(
              tag: '${item?.data?.id}${item?.data?.time}',
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: cacheImage(
                      item?.data?.cover?.feed ?? '',
                      width: 300,
                      height: 180,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Text(
                          item?.data?.category ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          formatDateMsByMS(item?.data?.duration ?? 0 * 1000),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              item?.data?.title ?? '',
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          Text(
            formatDateMsByYMDHM(item?.data?.author?.latestReleaseTime ?? 0),
            style: const TextStyle(color: Colors.black38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
