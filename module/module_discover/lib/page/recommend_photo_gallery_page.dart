import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_image/lib_image.dart';
import 'package:module_discover/viewmodel/photo_gallery_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:lib_navigator/lib_navigator.dart';

class RecommendPhotoGalleryPage extends StatelessWidget {
  final List<String> galleryItems;

  const RecommendPhotoGalleryPage({Key? key, required this.galleryItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        child: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: ProviderWidget<PhotoGalleryModel>(
                    model: PhotoGalleryModel(),
                    builder: (context, model, child) {
                      return Stack(
                        children: <Widget>[
                          PhotoViewGallery.builder(
                            builder: (BuildContext context, int index) =>
                                PhotoViewGalleryPageOptions(
                                    imageProvider: cachedNetworkImageProvider(
                                        galleryItems[index]),
                                    initialScale:
                                        PhotoViewComputedScale.contained * 1,
                                    minScale:
                                        PhotoViewComputedScale.contained * 1),
                            loadingBuilder: (context, event) => Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            itemCount: galleryItems.length,
                            enableRotation: true,
                            backgroundDecoration:
                                BoxDecoration(color: Colors.black),
                            onPageChanged: (index) {
                              model.changeIndex(index);
                            },
                          ),
                          Positioned(
                              left: 10,
                              top: MediaQuery.of(context).padding.top + 10,
                              child: GestureDetector(
                                onTap: () => back(),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: 24,
                                  height: 24,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Offstage(
                              offstage: galleryItems.length == 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top +
                                        15),
                                padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    '${model.currentIndex}/${galleryItems.length}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          )
                        ],
                      );
                    }))),
        value: SystemUiOverlayStyle.light);
  }
}
