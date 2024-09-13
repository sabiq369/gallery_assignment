import 'dart:developer';

import 'package:gallery/services/services.dart';
import 'package:gallery/views/gallery/model/gallery_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GalleryController extends GetxController {
  GalleryModel? galleryModel;
  RxBool onLoad = false.obs;

  apiCall() async {
    onLoad.value = true;
    var data = await Services().getGallery();
    if (data != null) {
      galleryModel = GalleryModel.fromJson(data);
      onLoad.value = false;
    }
  }

  @override
  void onInit() {
    apiCall();
    super.onInit();
  }
}
