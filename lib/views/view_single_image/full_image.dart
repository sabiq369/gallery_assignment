import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery/utils/widgets.dart';
import 'package:gallery/views/gallery/controller/gallery_controller.dart';
import 'package:get/get.dart';

class FullImage extends StatelessWidget {
  FullImage({super.key});
  final GalleryController controller = Get.find<GalleryController>();
  final PageController _pageController =
      PageController(); // Page controller for snapping

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView.builder(
        controller: _pageController,
        physics: const PageScrollPhysics(), // Disable scrolling by user
        scrollDirection: Axis.vertical,
        itemCount: controller.imageList.length - controller.tappedIndex,
        itemBuilder: (context, index) {
          return Hero(
            tag: "image${controller.tappedIndex}",
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: controller
                          .imageList[controller.tappedIndex + index]
                          .largeImageUrl,
                      placeholder: (context, url) => shimmer(),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,

                      // height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "${controller.imageList[controller.tappedIndex + index].likes} likes ❤️",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Text(
                      "${controller.imageList[controller.tappedIndex + index].views} views 👁️",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
