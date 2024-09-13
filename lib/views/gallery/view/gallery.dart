import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery/views/gallery/controller/gallery_controller.dart';
import 'package:get/get.dart';

class Gallery extends StatelessWidget {
  Gallery({Key? key}) : super(key: key);

  GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return controller.onLoad.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffEFEFEF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Search',
                              prefixIcon: Icon(CupertinoIcons.search)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.custom(
                        // physics: BouncingScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          pattern: [
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 2),
                          ],
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: controller.galleryModel!.hits.length,
                          (context, index) {
                            return CachedNetworkImage(
                              imageUrl: controller
                                  .galleryModel!.hits[index].previewUrl,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
