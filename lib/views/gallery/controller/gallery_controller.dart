import 'package:flutter/cupertino.dart';
import 'package:gallery/services/services.dart';
import 'package:gallery/views/view_single_image/full_image.dart';
import 'package:gallery/views/gallery/model/gallery_model.dart';
import 'package:get/get.dart';

class GalleryController extends GetxController {
  GalleryModel? galleryModel;
  RxBool onLoad = false.obs, loadMore = false.obs;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  List<Hit> imageList = [];
  int page = 1, tappedIndex = 0;

  goToFullImageScreen({required int index}) {
    tappedIndex = index;
    Get.to(() => FullImage(), transition: Transition.noTransition);
  }

  clearSearchKey(context) {
    textController.text = '';
    FocusScope.of(context).requestFocus(focusNode);
  }

  apiCall({bool clearSearchText = false}) async {
    if (!onLoad.value) {
      onLoad.value = true;
      imageList.clear();
      page = 1;
      if (clearSearchText) {
        textController.text = '';
      }
      var data = await Services()
          .getGallery(searchText: textController.text, page: page);
      if (data != null) {
        galleryModel = GalleryModel.fromJson(data);
        imageList.addAll(galleryModel!.hits);
        onLoad.value = false;
      }
    }
  }

  @override
  void onInit() {
    apiCall();
    scrollController.addListener(
      () async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          loadMore.value = true;
          page++;
          var data = await Services()
              .getGallery(searchText: textController.text, page: page);
          if (data != null) {
            galleryModel = GalleryModel.fromJson(data);
            imageList.addAll(galleryModel!.hits);
            loadMore.value = false;
          }
        } else {
          loadMore.value = false;
        }
      },
    );
    super.onInit();
  }
}
