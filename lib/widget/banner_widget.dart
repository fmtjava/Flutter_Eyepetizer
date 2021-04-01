import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/util/view_util.dart';
import 'package:flutter_eyepetizer/viewmodel/home_page_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_eyepetizer/page/video_detail_page.dart';
import 'package:flutter_eyepetizer/util/navigator_manager.dart';

class BannerWidget extends StatelessWidget {
  final HomePageModel model;

  const BannerWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: cachedNetworkImageProvider(
                            model.bannerList[index].data.cover.feed),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  width: MediaQuery.of(context).size.width - 30,
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Text(model.bannerList[index].data.title,
                          style: TextStyle(color: Colors.white, fontSize: 12))))
            ],
          );
        },
        onTap: (index) {
          toPage(VideoDetailPage(data: model.bannerList[index].data));
        },
        itemCount: model.bannerList?.length ?? 0,
        pagination: new SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
                size: 8,
                activeSize: 8,
                activeColor: Colors.white,
                color: Colors.white24)));
  }
}
