import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery/utils/colors.dart';
import 'package:gallery/utils/widgets.dart';
import 'package:gallery/views/gallery/controller/gallery_controller.dart';
import 'package:get/get.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key});

  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return controller.onLoad.value
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 5),
                              filled: true,
                              fillColor: ColorConstants.textFieldFill,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Search',
                              prefixIcon: const Icon(CupertinoIcons.search)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.custom(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          pattern: [
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 2),
                          ],
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: 50,
                          (context, index) {
                            return shimmer();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: controller.textController,
                          focusNode: controller.focusNode,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 5),
                              filled: true,
                              fillColor: ColorConstants.textFieldFill,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Search',
                              prefixIcon: const Icon(CupertinoIcons.search),
                              suffixIcon: controller.textController.text != ''
                                  ? IconButton(
                                      onPressed: () =>
                                          controller.clearSearchKey(context),
                                      icon: const Icon(Icons.close))
                                  : const SizedBox()),
                          onFieldSubmitted: (value) => controller.onLoad.value
                              ? null
                              : controller.textController.text != ''
                                  ? controller.apiCall()
                                  : FocusScope.of(context).requestFocus(),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        controller: controller.scrollController,
                        interactive: true,
                        radius: const Radius.circular(20),
                        thickness: 8,
                        child: GridView.custom(
                          controller: controller.scrollController,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            pattern: [
                              const QuiltedGridTile(2, 2),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 2),
                            ],
                            repeatPattern: QuiltedGridRepeatPattern.inverted,
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            childCount: controller.imageList.length,
                            (context, index) {
                              return GestureDetector(
                                onTap: () => controller.goToFullImageScreen(
                                    index: index),
                                child: Hero(
                                  tag: "image$index",
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                        .imageList[index].largeImageUrl,
                                    placeholder: (context, url) => shimmer(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    controller.loadMore.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: ColorConstants.shimmerBase,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.apiCall(clearSearchText: true),
        backgroundColor: Colors.black,
        child: const Icon(
          CupertinoIcons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
