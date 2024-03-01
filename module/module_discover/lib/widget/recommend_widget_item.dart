import 'package:flutter/material.dart';
import 'package:lib_image/lib_image.dart';
import 'package:lib_navigator/lib_navigator.dart';
import 'package:module_discover/model/recommend_model.dart';
import 'package:module_discover/page/recommend_photo_gallery_page.dart';
import 'package:module_discover/page/recommend_video_play_page.dart';

const VIDEO_TYPE = 'video';

class RecommendWidgetItem extends StatelessWidget {
  final RecommendItem item;

  const RecommendWidgetItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.data?.content?.type == VIDEO_TYPE) {
          toPage(RecommendVideoPlayPage(item: item));
        } else {
          toPage(RecommendPhotoGalleryPage(
            galleryItems: item.data?.content?.data?.urls ?? [],
          ));
        }
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageItem(context),
            _contentTextItem(),
            _infoTextItem()
          ],
        ),
      ),
    );
  }

  _imageItem(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var width = (item.data?.content?.data?.width == 0
            ? maxWidth
            : item.data?.content?.data?.width) ??
        0;
    var height = (item.data?.content?.data?.height == 0
            ? maxWidth
            : item.data?.content?.data?.height) ??
        0;

    Widget image = Stack(
      children: <Widget>[
        cacheImage(
          item.data?.content?.data?.cover?.feed ?? '',
          shape: BoxShape.rectangle,
          width: maxWidth,
          fit: BoxFit.cover,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
          clearMemoryCacheWhenDispose: true, //图片从 tree 中移除，清掉内存缓存，以减少内存压力
        ),
        Positioned(
            top: 5,
            right: 5,
            child: Offstage(
              offstage: item.data?.content?.data?.urls != null &&
                  item.data?.content?.data?.urls?.length == 1,
              child: Icon(
                item.data?.content?.type == VIDEO_TYPE
                    ? Icons.play_circle_outline
                    : Icons.photo_library,
                color: Colors.white,
                size: 18,
              ),
            ))
      ],
    );
    image = AspectRatio(
      //约束控件的宽高比，保证控件等比缩放
      aspectRatio: width / height,
      child: image,
    );
    return image;
  }

  _contentTextItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
      child: Text(
        item.data?.content?.data?.description ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  _infoTextItem() {
    return Container(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                PhysicalModel(
                  //类似于ClipRRect
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: cacheImage(
                    item.data?.content?.data?.owner?.avatar ?? '',
                    width: 24,
                    height: 24,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: 80,
                  child: Text(
                    item.data?.content?.data?.owner?.nickname ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.thumb_up,
                  size: 14,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    '${item.data?.content?.data?.consumption?.collectionCount}',
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
